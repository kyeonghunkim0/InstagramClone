# 처음 클론한 뒤 한 번: Template.xcconfig → Dev/Prod.xcconfig (이미 있으면 건너뜀)
setup:
	@for env in Dev Prod; do \
		if [ ! -f XCConfig/$$env.xcconfig ]; then \
			cp XCConfig/Template.xcconfig XCConfig/$$env.xcconfig; \
			echo "XCConfig/$$env.xcconfig 생성됨: 값을 환경에 맞게 수정하세요"; \
		fi; \
	done

generate: setup
	tuist install
	tuist generate

graph:
	tuist graph

clean:
	tuist clean
