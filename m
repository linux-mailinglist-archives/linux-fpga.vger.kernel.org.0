Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6ADCC3AE3C1
	for <lists+linux-fpga@lfdr.de>; Mon, 21 Jun 2021 09:06:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbhFUHIy (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 21 Jun 2021 03:08:54 -0400
Received: from first.geanix.com ([116.203.34.67]:54118 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230170AbhFUHIt (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 21 Jun 2021 03:08:49 -0400
Received: from 185.17.218.86 (unknown [185.17.218.86])
        by first.geanix.com (Postfix) with ESMTPSA id AAC414C3BBA;
        Mon, 21 Jun 2021 07:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=silicom.dk; s=first;
        t=1624259193; bh=FQ6OmgXuxLP0LFgo3KI2yKErrT4d+o1nxrmrp3bEEeo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=biRmxCoeMc1eeHhzn66fWqS0A12JgTku2fYxF3bgQQIRzqoLFUSYIqsWG0Kx5fP5x
         FkcojwIlBNEaMBpqsiyObxZalGB0RuF5EUpUlcrUewIC5B8Ynu0NQO7uVNWT75mN6V
         ilVLQu1z3gesU7I4gXA6G+FM8oyzz1gi634dBv/+W969vn0PZH/MYV2be6jJJSdBjr
         OWorwkB/TJJ1ESJxiK/GR1TgowlbzY7JfEDpdlwoapD9LTMxggvC8le0xtxGYzwRVS
         g2GODuB8S0EeY61Hrda6yt9ZDvvZMHnv4+7P100+X3pkEJ0voYaY0VpQIcyuD00v0g
         vnGlL8xJXbfWg==
From:   =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <mhu@silicom.dk>
To:     Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
        Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>
Cc:     =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <mhu@geanix.com>,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-spi@vger.kernel.org,
        =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <mhu@silicom.dk>
Subject: [PATCH 3/4] spi: spi-altera-dfl: support n5010 feature revision
Date:   Mon, 21 Jun 2021 09:06:20 +0200
Message-Id: <20210621070621.431482-4-mhu@silicom.dk>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210621070621.431482-1-mhu@silicom.dk>
References: <20210621070621.431482-1-mhu@silicom.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=4.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,TVD_RCVD_IP,TVD_RCVD_IP4,URIBL_BLOCKED
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on 93bd6fdb21b5
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

The Max10 BMC on the Silicom n5010 PAC is slightly different than the
existing BMC's, so use a dedicated feature revision detect it.

Signed-off-by: Martin Hundebøll <mhu@silicom.dk>
---
 drivers/spi/spi-altera-dfl.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-altera-dfl.c b/drivers/spi/spi-altera-dfl.c
index 3e32e4fe5895..d4908db39d87 100644
--- a/drivers/spi/spi-altera-dfl.c
+++ b/drivers/spi/spi-altera-dfl.c
@@ -111,6 +111,13 @@ static struct spi_board_info m10_bmc_info = {
 	.chip_select = 0,
 };
 
+static struct spi_board_info m10_n5010_bmc_info = {
+	.modalias = "m10-n5010",
+	.max_speed_hz = 12500000,
+	.bus_num = 0,
+	.chip_select = 0,
+};
+
 static void config_spi_master(void __iomem *base, struct spi_master *master)
 {
 	u64 v;
@@ -130,6 +137,7 @@ static void config_spi_master(void __iomem *base, struct spi_master *master)
 
 static int dfl_spi_altera_probe(struct dfl_device *dfl_dev)
 {
+	struct spi_board_info *board_info = &m10_bmc_info;
 	struct device *dev = &dfl_dev->dev;
 	struct spi_master *master;
 	struct altera_spi *hw;
@@ -172,9 +180,12 @@ static int dfl_spi_altera_probe(struct dfl_device *dfl_dev)
 		goto exit;
 	}
 
-	if (!spi_new_device(master,  &m10_bmc_info)) {
+	if (dfl_feature_revision(base) == FME_FEATURE_REV_MAX10_SPI_N5010)
+		board_info = &m10_n5010_bmc_info;
+
+	if (!spi_new_device(master, board_info)) {
 		dev_err(dev, "%s failed to create SPI device: %s\n",
-			__func__, m10_bmc_info.modalias);
+			__func__, board_info->modalias);
 	}
 
 	return 0;
-- 
2.31.0

