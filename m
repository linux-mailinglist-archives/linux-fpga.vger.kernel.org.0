Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C696958C2EA
	for <lists+linux-fpga@lfdr.de>; Mon,  8 Aug 2022 07:38:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbiHHFhD (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 8 Aug 2022 01:37:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230461AbiHHFhC (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 8 Aug 2022 01:37:02 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09EF05F55
        for <linux-fpga@vger.kernel.org>; Sun,  7 Aug 2022 22:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659937022; x=1691473022;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=I+icPUIF4PSCGzvIjX0Cosz2kZBkmXVksoaeE0F6qmU=;
  b=C80RbrbDw+CR1g6klpiGuCr1gEJiNjEMisJAzDnp5A7rQcF6d+KlwoTv
   MkIwp1gE80wczYvTnDRfdsKo0RpQg7tX1VN1yO9d0SbcSkdm91ZhvJJV6
   DDDQLunIsY7ZrDP4aI/ucgMgYsJezq42rq6akDdHZ7DIolLzjImcTI4fZ
   ysrGIYP0/647UVVwzBL/08LYl7EyFPwjPT5iaWYPod4Lb8hDVe1ga3FGL
   2S9MwVtZVaDnERiKoQ7ZEvGUwuJwPTCGXGZHGvnCivCedUkMaTD+v7Now
   6b0s50FXqOUManzFy70nb6QW1SJ6/VyxFxnXR0R1yOtor/wo0eZIXu168
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10432"; a="273555372"
X-IronPort-AV: E=Sophos;i="5.93,221,1654585200"; 
   d="scan'208";a="273555372"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2022 22:37:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,221,1654585200"; 
   d="scan'208";a="931900902"
Received: from unknown (HELO opae-zj-2.sh.intel.com) ([10.238.175.107])
  by fmsmga005.fm.intel.com with ESMTP; 07 Aug 2022 22:36:59 -0700
From:   Tianfei Zhang <tianfei.zhang@intel.com>
To:     mdf@kernel.org, yilun.xu@intel.com, linux-fpga@vger.kernel.org,
        lee.jones@linaro.org, russell.h.weight@intel.com
Cc:     hao.wu@intel.com, trix@redhat.com,
        Tianfei Zhang <tianfei.zhang@intel.com>
Subject: [PATCH v3 0/2] add Intel FPGA image reload support
Date:   Mon,  8 Aug 2022 01:33:15 -0400
Message-Id: <20220808053317.3627-1-tianfei.zhang@intel.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

This patchset adds FPGA image reload support on Intel PAC N3000 Card.
Image reload means that a reload mechanism of an FPGA, BMC, or
firmware image from FLASH or EEPROM after flash or program the images
without power cycle the server.

This patchset introduces 2 new sysfs files for query the available
images and trigger a image reload.

patch 1: add the available_images and image_load sysfs files.
Write a key word into image_load sysfs file to trigger a reload of an
FPGA, BMC, or firmware image from FLASH or EEPROM.
patch 2: add a trigger to update a new Retimer firmware.

v3:
From Lee Jones's comment, uses regmap_update_bits() API instead of
the wrapper of m10bmc_sys_update_bits().
v2:
add more detail about how to use the image_load sysfs files in ABI
documentation.

Russ Weight (2):
  fpga: m10bmc-sec: add sysfs to reload FPGA/BMC images
  fpga: m10bmc-sec: add m10bmc_sec_retimer_load callback

 .../sysfs-driver-intel-m10-bmc-sec-update     |  34 +++
 drivers/fpga/intel-m10-bmc-sec-update.c       | 253 ++++++++++++++++++
 include/linux/mfd/intel-m10-bmc.h             |  31 +++
 3 files changed, 318 insertions(+)

-- 
2.26.2

