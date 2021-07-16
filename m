Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8751C3CB820
	for <lists+linux-fpga@lfdr.de>; Fri, 16 Jul 2021 15:54:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239738AbhGPN5w (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 16 Jul 2021 09:57:52 -0400
Received: from first.geanix.com ([116.203.34.67]:35038 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232088AbhGPN5w (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Fri, 16 Jul 2021 09:57:52 -0400
Received: from zen.. (unknown [185.17.218.86])
        by first.geanix.com (Postfix) with ESMTPSA id 982994C7135;
        Fri, 16 Jul 2021 13:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1626443694; bh=Em7PjSoXenIt5zoQnSrFagVO2cjkXgWtRzWVFLohT04=;
        h=From:To:Cc:Subject:Date;
        b=cxjcHJVTVzaI3TWfDG2Xdvr4hYzCnl82pIjxLw+PYsRY0ZZaNWNXnSTBDXBaNC2YL
         /F1lhd0fCp6Az5Z2BvvpbUsQo4grxWy4BCqMibs5aKP0D2RWYJGAI+d5Aa5v0B6TdA
         +Jj9NyBACG1sv2q2LAW25io1jg4MZz8kEiKaExXuIwi9g/LO3h8JyILqMhWX0hOsxO
         DevSsNp/0cWBmEvzfhPSmx8UBSHz5OrikgkShqsJYIRMZg/GYiPQ1dG5g0Zvkjjy7X
         cE7lhyheq9TH/Zzr3H10cmS3hrFPtOZOSCR/GgFEGcx7Xzz9V/z3EhLJyN3N6/bhQ8
         lFLQppRTK6NqQ==
From:   =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>
To:     Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
        Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Mark Brown <broonie@kernel.org>
Cc:     =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <mhu@silicom.dk>,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-spi@vger.kernel.org
Subject: [PATCH v5 0/3] fpga/spi/hwmon: Initial support for Silicom N5010 PAC
Date:   Fri, 16 Jul 2021 15:54:38 +0200
Message-Id: <20210716135441.3235863-1-martin@geanix.com>
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

Based on v5.14-rc1

Changes since v4:
 * Removed the mfd patch that has been applied by Lee
 * Renamed 'rev' to 'revision' in patch 1/3 as per Tom's suggestion
 * Moved spi board_info structure in patch 2/3 from global/static scope
   to function/stack scope

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

Martin Hundebøll (3):
  fpga: dfl: expose feature revision from struct dfl_device
  spi: spi-altera-dfl: support n5010 feature revision
  hwmon: intel-m10-bmc-hwmon: add n5010 sensors

 drivers/fpga/dfl.c                  |  27 ++++---
 drivers/fpga/dfl.h                  |   1 +
 drivers/hwmon/intel-m10-bmc-hwmon.c | 116 ++++++++++++++++++++++++++++
 drivers/spi/spi-altera-dfl.c        |  21 ++---
 include/linux/dfl.h                 |   1 +
 5 files changed, 147 insertions(+), 19 deletions(-)

-- 
2.31.0

