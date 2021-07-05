Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18E5F3BBB06
	for <lists+linux-fpga@lfdr.de>; Mon,  5 Jul 2021 12:17:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230484AbhGEKTk (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 5 Jul 2021 06:19:40 -0400
Received: from first.geanix.com ([116.203.34.67]:59018 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230355AbhGEKTj (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 5 Jul 2021 06:19:39 -0400
Received: from zen.. (unknown [185.17.218.86])
        by first.geanix.com (Postfix) with ESMTPSA id ACAD64C5381;
        Mon,  5 Jul 2021 10:16:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1625480219; bh=rvFgEeXnI9vkm2Fu4+wIha0lvYvPjxqtonLZHLSIF8g=;
        h=From:To:Cc:Subject:Date;
        b=Tdwqs3LNrodRopK8al7EB4SDJIjHtHQKf4vY5C2JFCpEaGlXPnlfQxCz718xWmN3Y
         3t22ZFvtUfI0Nvze24gxQwQ6huARXx7Tou/BwaREFcWRk/6z9H6nEIniHyjuL7SzAV
         HqS/vXzutGVgFACuBBJs2pE8D8GxZyrq51LPiXe1/6MvgAvcA27dWZSoD478a/Hk8d
         j86wWZeC8Hb4tcVSWuchWHuXZwPEBDK0D2XVsAFY4/+aUACMQcRV3KwkkCEUCJbah3
         43HUi/voSZk4Rc8+4vWEVBo/LE6mriSSKupFfw7wrQSKl6Jr6UDXpIMz3s0vLsg7eK
         KHIWmM1nkwjBQ==
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
Subject: [PATCH v4 0/4] fpga/mfd/hwmon: Initial support for Silicom N5010 PAC
Date:   Mon,  5 Jul 2021 12:16:41 +0200
Message-Id: <20210705101645.2040106-1-martin@geanix.com>
X-Mailer: git-send-email 2.31.0
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

This is an initial set of patches for the Silciom N5010 programmable
accelerated card adding support for reading out sensors.

Based on v5.13

Changes since v3:
 * Added Hao's Acked-by to patch 1/4
 * Added Matthew's Acked-by to patch 1/4
 * Changed "BMC's" to "BMCs" in patch 2/4
 * Added Moritz' Reviewed-by to patch 2/4
 * Added Matthew's Reviewed-by to patch 3/4
 * Added Lee's Acked-for-MFD-by to patch 3/4

Changes since v2:
 * Removed patch 1/5 from v2 already in fpga/for-next
 * Reworded commit message in patch 1/4 as per Hao's suggestion
 * Added Yilun's Reviewed-by to patch 3/4 and 4/4
 * Added Moritz' Acked-by to patch 3/4
 * Added Moritz' Reviewed-by to patch 4/4
 * Added Guenter's Reviewed-by to patch 4/4

Changes since v1:
 * Commit message in patch 1 is updated with card description
 * Added Hao's Acked-by to patch 1
 * Patch 2 is replaced with a new patch to carry feature revision info
   in struct dfl_device
 * Patch 3 is updated to use feature revision from struct dfl_device
 * Patch 4 from v0 is split into separate patches for hwmon and mfd

Martin Hundebøll (4):
  fpga: dfl: expose feature revision from struct dfl_device
  spi: spi-altera-dfl: support n5010 feature revision
  mfd: intel-m10-bmc: add n5010 variant
  hwmon: intel-m10-bmc-hwmon: add n5010 sensors

 drivers/fpga/dfl.c                  |  27 ++++---
 drivers/fpga/dfl.h                  |   1 +
 drivers/hwmon/intel-m10-bmc-hwmon.c | 116 ++++++++++++++++++++++++++++
 drivers/mfd/intel-m10-bmc.c         |  12 ++-
 drivers/spi/spi-altera-dfl.c        |  15 +++-
 include/linux/dfl.h                 |   1 +
 6 files changed, 159 insertions(+), 13 deletions(-)

-- 
2.31.0

