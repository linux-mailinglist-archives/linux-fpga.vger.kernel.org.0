Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C00E5664D4
	for <lists+linux-fpga@lfdr.de>; Tue,  5 Jul 2022 10:17:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbiGEIEe (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 5 Jul 2022 04:04:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiGEIEe (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 5 Jul 2022 04:04:34 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D86A66333
        for <linux-fpga@vger.kernel.org>; Tue,  5 Jul 2022 01:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657008273; x=1688544273;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=o/UEf5Nitj8UwyVvMUgAIQTQBiGM3oaK+cO6iHMAJbc=;
  b=IaCLIyORXNAUXrgUHcYqXTPxlwdMtxr4MR5M3kXbob3hHA9xJBWzSwYp
   U44V9ZF+WukCYnE3XbnoEfcuK6ENxmuGMwCwju2Q9WoRY5e/bvstMpFVG
   Ztadk6cszb6Y3P0tNPNY9HLqEWlTwrUtkKNNXY2d6+4Y1FjRWPyMhFjPa
   OO1MKO9cg6jWPJev6u+XchvY1H2Gqk98tDYy8B4DFODeM5WB+EhYpzucz
   Ymw3s5+MpktHqTIoyTUKvzTz+R/eRljRYt5cNdPzd+NwvvokUM3FzrCV8
   jfVPR4awVbYzgfw5wTfHNsTwuF+q0bD9i9dRo70MyXfRULLnGFSBUgMGM
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10398"; a="369608995"
X-IronPort-AV: E=Sophos;i="5.92,245,1650956400"; 
   d="scan'208";a="369608995"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2022 01:04:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,245,1650956400"; 
   d="scan'208";a="919613404"
Received: from unknown (HELO localhost.localdomain.sh.intel.com) ([10.238.175.107])
  by fmsmga005.fm.intel.com with ESMTP; 05 Jul 2022 01:04:31 -0700
From:   Tianfei Zhang <tianfei.zhang@intel.com>
To:     mdf@kernel.org, yilun.xu@intel.com, lee.jones@linaro.org,
        russell.h.weight@intel.com
Cc:     hao.wu@intel.com, trix@redhat.com, linux-fpga@vger.kernel.org,
        Tianfei Zhang <tianfei.zhang@intel.com>
Subject: [PATCH v1 0/3] add Intel FPGA image loader support
Date:   Tue,  5 Jul 2022 04:00:55 -0400
Message-Id: <20220705080058.92532-1-tianfei.zhang@intel.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

This patchset adds FPGA image loader support on Intel PAC N3000 Card.
Image loader means that a reload mechanism of an FPGA, BMC, or
firmware image from FLASH or EEPROM after flash or program the images
without power cycle the server.

This patchset introduces 2 new sysfs files for query the available
images and trigger a image reload.

patch 1: add register access helper functions for M10BMC.
patch 2: add the available_images and image_load sysfs files.
Write a key word into image_load sysfs file to trigger a reload of an
FPGA, BMC, or firmware image from FLASH or EEPROM.
patch 3: add a trigger to update a new Retimer firmware.

Russ Weight (2):
  fpga: m10bmc-sec: add sysfs to load bmc images
  fpga: m10bmc-sec: add m10bmc_sec_retimer_load callback

Tianfei Zhang (1):
  mfd: intel-m10-bmc: add m10bmc_sys_update_bits API

 .../sysfs-driver-intel-m10-bmc-sec-update     |  21 ++
 drivers/fpga/intel-m10-bmc-sec-update.c       | 250 ++++++++++++++++++
 include/linux/mfd/intel-m10-bmc.h             |  49 ++++
 3 files changed, 320 insertions(+)

-- 
2.26.2

