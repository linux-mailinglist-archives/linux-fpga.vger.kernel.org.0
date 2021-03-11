Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3804A337741
	for <lists+linux-fpga@lfdr.de>; Thu, 11 Mar 2021 16:27:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234238AbhCKP0b (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 11 Mar 2021 10:26:31 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:34055 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234253AbhCKP0K (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 11 Mar 2021 10:26:10 -0500
Received: from mail-lj1-f199.google.com ([209.85.208.199])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lKNCT-00054K-4F
        for linux-fpga@vger.kernel.org; Thu, 11 Mar 2021 15:26:09 +0000
Received: by mail-lj1-f199.google.com with SMTP id u4so8654973ljo.6
        for <linux-fpga@vger.kernel.org>; Thu, 11 Mar 2021 07:26:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Xs6GGjw8nQu2H0zJNhMFfPjtjv4pASlZetLF+qPJ3jI=;
        b=HCfYffddV4ho4BwmOCtHkJqbq4ookxH6Ca5MnsDr8g3d8KvOBM3IEPTQqHzF3VxRPg
         /B8RxbUsvATO41aGqFZId3AjpaFi+0wtd7qVA0Yq+4BvuzB7dtXk5OwQLWeT1JKOKWLc
         24QkkflqrJeyaI8pOmYmwtlmhyJyJaiSkk+h4LF8ZjYGdZ1OEgNSDjZ56N95hl/Iszgv
         VTNePXXWVXqpYGTMN2Mff7oOcbuC9uzqkfdpsIBizeQhq5WRb0WbmYjGJH2IAQlo2cq9
         bmVe64z6JVdhp1ZkK7rgtKG2+iAflPOYuc5vO7RvZvNdiNaZozen0d8751HXJVDkl23x
         /nQg==
X-Gm-Message-State: AOAM532w2yhIC4xBzFImMjY5kNDM0W7in1hpIoz1Cc81YXPXi/QfDIvV
        Rd1q7U8A+8vy0ONnQsf47sEZl6i1PLyqE0Ga8+jd8Qlw4v+LnytOWzPC0tLdGVnvS38tPdex8Xs
        Xqyjdp4MQPOErxZUS1wBqCWH7JTYdaWUGP7HRFf4=
X-Received: by 2002:a05:6402:2070:: with SMTP id bd16mr9026001edb.133.1615476357799;
        Thu, 11 Mar 2021 07:25:57 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxEy/VWcYtVhHpWmtyv1K3JAU4Nmfhx02KoGEuoEu8P/ERdDmK4z05THjQn7v4EX/URDdO6zA==
X-Received: by 2002:a05:6402:2070:: with SMTP id bd16mr9025945edb.133.1615476357547;
        Thu, 11 Mar 2021 07:25:57 -0800 (PST)
Received: from localhost.localdomain (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.gmail.com with ESMTPSA id v25sm1517826edr.18.2021.03.11.07.25.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 07:25:57 -0800 (PST)
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
Subject: [PATCH v3 06/15] clk: socfpga: merge ARCH_SOCFPGA and ARCH_STRATIX10
Date:   Thu, 11 Mar 2021 16:25:36 +0100
Message-Id: <20210311152545.1317581-7-krzysztof.kozlowski@canonical.com>
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

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/clk/Makefile | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index 12e46b12e587..1e29e5ad107a 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -104,10 +104,9 @@ obj-y					+= renesas/
 obj-$(CONFIG_ARCH_ROCKCHIP)		+= rockchip/
 obj-$(CONFIG_COMMON_CLK_SAMSUNG)	+= samsung/
 obj-$(CONFIG_CLK_SIFIVE)		+= sifive/
-obj-$(CONFIG_ARCH_SOCFPGA)		+= socfpga/
+obj-$(CONFIG_ARCH_INTEL_SOCFPGA)	+= socfpga/
 obj-$(CONFIG_ARCH_AGILEX)		+= socfpga/
 obj-$(CONFIG_ARCH_N5X)			+= socfpga/
-obj-$(CONFIG_ARCH_STRATIX10)		+= socfpga/
 obj-$(CONFIG_PLAT_SPEAR)		+= spear/
 obj-y					+= sprd/
 obj-$(CONFIG_ARCH_STI)			+= st/
-- 
2.25.1

