Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E62493B3DCE
	for <lists+linux-fpga@lfdr.de>; Fri, 25 Jun 2021 09:43:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbhFYHpO (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 25 Jun 2021 03:45:14 -0400
Received: from first.geanix.com ([116.203.34.67]:34920 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230072AbhFYHpL (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Fri, 25 Jun 2021 03:45:11 -0400
Received: from zen.. (unknown [185.17.218.86])
        by first.geanix.com (Postfix) with ESMTPSA id 2575E4C41C3;
        Fri, 25 Jun 2021 07:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1624606969; bh=OKf6/wgB4ByxaDS2MUvVAWCddXMhFEU98vb6qMw2YFY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=mmAUhgMbswgWarxJrCs4wz7LlzzraEhgzo1XE3e04M1OBcDUEZiYmP10wRX8/5tKl
         mgC1m4YctSvqdVART116Z2pwkYGN2QZ8zeLxrKnwtljaDYjbM70BeOygDaXR/BNQnp
         DQeYpROeZLPRQngUsScBuVjrF4C5IrYt5PSrF8DCscca62EMwSn05GanFI2pMTqjmN
         ssNYCEFDLXcHUTzX7W9vOnMBouZXp6uZTDtNCgpHUJwfk4PCjvtb3+3bWmgCNe5fYG
         4o+KZgtbtcZpTbmWENCY25NKVjD20IV+BqX1JH8mrR4WmVbEcEzvGM0wrVeK7lb53v
         7Ab0tWtMApANw==
From:   =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>
To:     Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
        Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>
Cc:     =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <mhu@silicom.dk>,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-spi@vger.kernel.org
Subject: [PATCH v2 4/5] mfd: intel-m10-bmc: add n5010 variant
Date:   Fri, 25 Jun 2021 09:42:12 +0200
Message-Id: <20210625074213.654274-5-martin@geanix.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210625074213.654274-1-martin@geanix.com>
References: <20210625074213.654274-1-martin@geanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=4.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,URIBL_BLOCKED
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on 93bd6fdb21b5
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Martin Hundebøll <mhu@silicom.dk>

 The m10-bmc is used on the Silicom N5010 PAC too, so add it to list of
 m10bmc types.

Signed-off-by: Martin Hundebøll <mhu@silicom.dk>
---

Changes since v1:
 * Patch split out to separate mfd changes

 drivers/mfd/intel-m10-bmc.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/intel-m10-bmc.c b/drivers/mfd/intel-m10-bmc.c
index 1a9bfb7f48cd..8db3bcf5fccc 100644
--- a/drivers/mfd/intel-m10-bmc.c
+++ b/drivers/mfd/intel-m10-bmc.c
@@ -15,7 +15,8 @@
 
 enum m10bmc_type {
 	M10_N3000,
-	M10_D5005
+	M10_D5005,
+	M10_N5010,
 };
 
 static struct mfd_cell m10bmc_d5005_subdevs[] = {
@@ -28,6 +29,10 @@ static struct mfd_cell m10bmc_pacn3000_subdevs[] = {
 	{ .name = "n3000bmc-secure" },
 };
 
+static struct mfd_cell m10bmc_n5010_subdevs[] = {
+	{ .name = "n5010bmc-hwmon" },
+};
+
 static const struct regmap_range m10bmc_regmap_range[] = {
 	regmap_reg_range(M10BMC_LEGACY_BUILD_VER, M10BMC_LEGACY_BUILD_VER),
 	regmap_reg_range(M10BMC_SYS_BASE, M10BMC_SYS_END),
@@ -192,6 +197,10 @@ static int intel_m10_bmc_spi_probe(struct spi_device *spi)
 		cells = m10bmc_d5005_subdevs;
 		n_cell = ARRAY_SIZE(m10bmc_d5005_subdevs);
 		break;
+	case M10_N5010:
+		cells = m10bmc_n5010_subdevs;
+		n_cell = ARRAY_SIZE(m10bmc_n5010_subdevs);
+		break;
 	default:
 		return -ENODEV;
 	}
@@ -207,6 +216,7 @@ static int intel_m10_bmc_spi_probe(struct spi_device *spi)
 static const struct spi_device_id m10bmc_spi_id[] = {
 	{ "m10-n3000", M10_N3000 },
 	{ "m10-d5005", M10_D5005 },
+	{ "m10-n5010", M10_N5010 },
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, m10bmc_spi_id);
-- 
2.31.0

