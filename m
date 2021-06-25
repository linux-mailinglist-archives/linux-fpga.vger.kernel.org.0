Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 787243B3DBE
	for <lists+linux-fpga@lfdr.de>; Fri, 25 Jun 2021 09:42:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbhFYHpH (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 25 Jun 2021 03:45:07 -0400
Received: from first.geanix.com ([116.203.34.67]:34880 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229474AbhFYHpH (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Fri, 25 Jun 2021 03:45:07 -0400
Received: from zen.. (unknown [185.17.218.86])
        by first.geanix.com (Postfix) with ESMTPSA id 0B3A54C41AF;
        Fri, 25 Jun 2021 07:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1624606964; bh=gSgxnotvFWjxmyiWvry2LQo2dRMw5YZN5NOHhaPPBNU=;
        h=From:To:Cc:Subject:Date;
        b=I+IjEbkVotK4Ajs5M1I1HGy9ivLYPeI6QWBwGXnmyp+tyfZRI0kmPgfk176Td9s18
         91Ns3gL0+bPFck2NTadAFdGN7QvK86qZq7HjPvfzDAjOq3s8iVDo7dhH2+47XzVHPx
         fEkGYZFSZ/2omytzd5OJ8L30zsrMV/S9yQWUgPIpyzaldyNnNZqVO/Afl+TL8lyJaq
         FXpj6toam+VpEl22QWZIDjXdAkczNzGQW78pI8i3ImdKi3ibwg2QJk7+p6uUobl47a
         7nly2FKLJ3epopbiMmyGuEkpYQJoVxPhWrNwVxfxoQ/X9Axh2c1Q8w585Tc00RnqJa
         87WiLWoOMdkzw==
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
Subject: [PATCH v2 0/5] fpga/mfd/hwmon: Initial support for Silicom N5010 PAC
Date:   Fri, 25 Jun 2021 09:42:08 +0200
Message-Id: <20210625074213.654274-1-martin@geanix.com>
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

Based on v5.13-rc7

Changes since v1:
 * Commit message in patch 1 is updated with card description
 * Added Hao's Acked-by to patch 1
 * Patch 2 is replaced with a new patch to carry feature revision info
   in struct dfl_device
 * Patch 3 is updated to use feature revision from struct dfl_device
 * Patch 4 from v0 is split into separate patches for hwmon and mfd

Martin Hundebøll (5):
  fpga: dfl: pci: add device IDs for Silicom N501x PAC cards
  fpga: dfl: expose feature revision from struct dfl_device
  spi: spi-altera-dfl: support n5010 feature revision
  mfd: intel-m10-bmc: add n5010 variant
  hwmon: intel-m10-bmc-hwmon: add n5010 sensors

 drivers/fpga/dfl-pci.c              |   5 ++
 drivers/fpga/dfl.c                  |  27 ++++---
 drivers/fpga/dfl.h                  |   1 +
 drivers/hwmon/intel-m10-bmc-hwmon.c | 116 ++++++++++++++++++++++++++++
 drivers/mfd/intel-m10-bmc.c         |  12 ++-
 drivers/spi/spi-altera-dfl.c        |  15 +++-
 include/linux/dfl.h                 |   1 +
 7 files changed, 164 insertions(+), 13 deletions(-)

-- 
2.31.0

