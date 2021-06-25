Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20CCF3B3DCC
	for <lists+linux-fpga@lfdr.de>; Fri, 25 Jun 2021 09:43:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbhFYHpN (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 25 Jun 2021 03:45:13 -0400
Received: from first.geanix.com ([116.203.34.67]:34952 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230025AbhFYHpK (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Fri, 25 Jun 2021 03:45:10 -0400
Received: from zen.. (unknown [185.17.218.86])
        by first.geanix.com (Postfix) with ESMTPSA id CD7334C41C2;
        Fri, 25 Jun 2021 07:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1624606968; bh=KqpbJ6G/4HtHo9jdTQoQrgQLylu4HU0NQpLl5hC5Uok=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=K+6Ao/sSZOLuKeZcKFLeNjy+uUAtdSmWpBp4oa9XG7PJfaysbtQY01oedcKV9PRsr
         5tEUj1eeuQHf8R8mUTGPUok1zaIp3J0Z9bh/qZfB6uUnQ45k19+7RV5ZCnuIbOXjKF
         rXEv/MxJFR3Qmv4f9h6gFXNcymbJXJM09MKu7FwsAn9HDVTqT/1CNSbSVhc+OKh/vp
         rxb2i9YuOS140XWVtSnM7pdE8XwW7DFINq5GuiwI2TawNhr9vvAduIedE4BFbDECoZ
         3nvayORsaN5MVG33mZtNnOT3NsvuOjTdjaguN4AwTXyO5zn4UEoKYhWKLP0XICfRz7
         vyUc+0Y5hWy2w==
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
Subject: [PATCH v2 3/5] spi: spi-altera-dfl: support n5010 feature revision
Date:   Fri, 25 Jun 2021 09:42:11 +0200
Message-Id: <20210625074213.654274-4-martin@geanix.com>
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

The Max10 BMC on the Silicom n5010 PAC is slightly different than the
existing BMC's, so use a dedicated feature revision detect it.

Signed-off-by: Martin Hundebøll <mhu@silicom.dk>
---

Changes since v1:
 * use feature revision from struct dfl_device instead of reading it
   from io-mem

 drivers/spi/spi-altera-dfl.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-altera-dfl.c b/drivers/spi/spi-altera-dfl.c
index 3e32e4fe5895..f6cf7c8d9dac 100644
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
+	if (dfl_dev->revision == FME_FEATURE_REV_MAX10_SPI_N5010)
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

