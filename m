Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EEB6337732
	for <lists+linux-fpga@lfdr.de>; Thu, 11 Mar 2021 16:27:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234099AbhCKP01 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 11 Mar 2021 10:26:27 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:33856 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234132AbhCKPZ4 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 11 Mar 2021 10:25:56 -0500
Received: from mail-ej1-f70.google.com ([209.85.218.70])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lKNCF-0004ng-12
        for linux-fpga@vger.kernel.org; Thu, 11 Mar 2021 15:25:55 +0000
Received: by mail-ej1-f70.google.com with SMTP id r26so8841046eja.22
        for <linux-fpga@vger.kernel.org>; Thu, 11 Mar 2021 07:25:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JtLWGKzddsZdneeyVDqkoKKRKkrCkmXH8NCFoh7fPmQ=;
        b=cTikdn15IRG9d1tqtdxmMRD/obSuTF3EAjBl6N/wIghBwqSrHNinjDGdD8VWuxl4Cf
         P5QcjWQxH2swe9YvIRQlY7bd2VZRQbmxTkGGxH5VDpsGa606ZZuvvvUMM9iKuJVY2OxO
         6mZZcWuZGHltkc95Hwh6gf/9xmzloeHp1D5/BkBbA8pPm/xmFql1ttcT+lbskTUhGGax
         0CLiyedyVGyUttrXZWI97urHsUfnx02fasDwC1E7E1nLs1eoNestKeWuXYgNOyYOW3h3
         jG3OTOf+VsZ0x8xeX0bCUnB+MPWMCCQr9+N7v71467reRbc/nD+YEENP+F9lJyD/1gax
         FV3Q==
X-Gm-Message-State: AOAM531tiN2unC3x95UoOxkALxWW7oDy7THnwyCjOsiT4wvtdpbEDOEi
        Rl0i7NKATtZPDCgH9mendet6OM/pVbLpfxGjiHvOKd7EPG+DJFS8Ic72vUsbFCwQfDXYEM0NuL6
        1nXSfqSvpDt6ZzuRPZliX4H3Y5wZA8QdoXpGbD5Y=
X-Received: by 2002:a17:906:c1ca:: with SMTP id bw10mr3657256ejb.510.1615476354695;
        Thu, 11 Mar 2021 07:25:54 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzGGDs0d4jf9iY6zfDpEMPiHECUlKXPHLkk7gQWMVmAU9DMsqo4KBX6VOy9u5EuqygNiPRNmA==
X-Received: by 2002:a17:906:c1ca:: with SMTP id bw10mr3657235ejb.510.1615476354507;
        Thu, 11 Mar 2021 07:25:54 -0800 (PST)
Received: from localhost.localdomain (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.gmail.com with ESMTPSA id v25sm1517826edr.18.2021.03.11.07.25.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 07:25:54 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, Rob Herring <robh+dt@kernel.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>,
        Moritz Fischer <mdf@kernel.org>, Tom Rix <trix@redhat.com>,
        Lee Jones <lee.jones@linaro.org>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-edac@vger.kernel.org,
        linux-fpga@vger.kernel.org, linux-i2c@vger.kernel.org,
        netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH v3 03/15] mfd: altera: merge ARCH_SOCFPGA and ARCH_STRATIX10
Date:   Thu, 11 Mar 2021 16:25:33 +0100
Message-Id: <20210311152545.1317581-4-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210311152545.1317581-1-krzysztof.kozlowski@canonical.com>
References: <20210311152545.1317581-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Simplify 32-bit and 64-bit Intel SoCFPGA Kconfig options by having only
one for both of them.  This the common practice for other platforms.
Additionally, the ARCH_SOCFPGA is too generic as SoCFPGA designs come
from multiple vendors.

The side effect is that the MFD_ALTERA_A10SR will now be available for
both 32-bit and 64-bit Intel SoCFPGA, even though it is used only for
32-bit.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/mfd/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index a03de3f7a8ed..8af8c3196f1d 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -21,7 +21,7 @@ config MFD_CS5535
 
 config MFD_ALTERA_A10SR
 	bool "Altera Arria10 DevKit System Resource chip"
-	depends on ARCH_SOCFPGA && SPI_MASTER=y && OF
+	depends on ARCH_INTEL_SOCFPGA && SPI_MASTER=y && OF
 	select REGMAP_SPI
 	select MFD_CORE
 	help
@@ -32,7 +32,7 @@ config MFD_ALTERA_A10SR
 
 config MFD_ALTERA_SYSMGR
 	bool "Altera SOCFPGA System Manager"
-	depends on (ARCH_SOCFPGA || ARCH_STRATIX10) && OF
+	depends on ARCH_INTEL_SOCFPGA && OF
 	select MFD_SYSCON
 	help
 	  Select this to get System Manager support for all Altera branded
-- 
2.25.1

