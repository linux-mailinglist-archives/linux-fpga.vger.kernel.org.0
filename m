Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7805459296E
	for <lists+linux-fpga@lfdr.de>; Mon, 15 Aug 2022 08:13:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbiHOGLV (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 15 Aug 2022 02:11:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232530AbiHOGLH (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 15 Aug 2022 02:11:07 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBC8E18B0C
        for <linux-fpga@vger.kernel.org>; Sun, 14 Aug 2022 23:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660543865; x=1692079865;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=QBlZIGCuvj5GlmgRunaEESxZJARgab8dSTzFaeF7EFE=;
  b=i+2Ejgt3jgL2Z/3ptAasBAg35hiMJBjrmOG+AHnHL051Slpx2CLtWpD6
   vNTrbALQ+5UZpVrpo+EMPBP7LqFAXCNDSlEVhlgF+GXk0RrekrtoN2KBS
   ukTzuqVYSRHX3zvOylY+ZMCfpJQ9CTeCCE3zKpwYcyG4j3xCkC81kCoHw
   J6hXQyZRUte0yccuUkyT0fvmBsSf9PKaacl0Lmc5CiJancKp2B29zx/2u
   w4AzpEbyht9RbpMOEqRzxnHdu+TBDPF1Ib/lI79P4Icdlr6LvBX7VwRnV
   QgwPGsOdSnJ2nDAqy3SoJMPPn526pVbunO8iLA6rE2gWVxXNnw/wIfkFD
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10439"; a="271670706"
X-IronPort-AV: E=Sophos;i="5.93,237,1654585200"; 
   d="scan'208";a="271670706"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2022 23:11:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,237,1654585200"; 
   d="scan'208";a="639544874"
Received: from unknown (HELO opae-zj-2.sh.intel.com) ([10.238.175.107])
  by orsmga001.jf.intel.com with ESMTP; 14 Aug 2022 23:11:02 -0700
From:   Tianfei Zhang <tianfei.zhang@intel.com>
To:     mdf@kernel.org, yilun.xu@intel.com, linux-fpga@vger.kernel.org,
        lee.jones@linaro.org, russell.h.weight@intel.com
Cc:     hao.wu@intel.com, trix@redhat.com,
        Tianfei Zhang <tianfei.zhang@intel.com>
Subject: [PATCH v4 0/2] add Intel FPGA image reload support
Date:   Mon, 15 Aug 2022 02:07:13 -0400
Message-Id: <20220815060715.37712-1-tianfei.zhang@intel.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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

v4:
From Yilun and Matthew's comments, provide more detail about how
to trigger the FPGA/BMC image reload.
v3:
From Lee Jones's comment, uses regmap_update_bits() API instead of
the wrapper of m10bmc_sys_update_bits().
v2:
add more detail about how to use the image_load sysfs files in ABI
documentation.

Russ Weight (2):
  fpga: m10bmc-sec: add sysfs to trigger FPGA/BMC images reload
  fpga: m10bmc-sec: add m10bmc_sec_retimer_load callback

 .../sysfs-driver-intel-m10-bmc-sec-update     |  41 +++
 drivers/fpga/intel-m10-bmc-sec-update.c       | 253 ++++++++++++++++++
 include/linux/mfd/intel-m10-bmc.h             |  31 +++
 3 files changed, 325 insertions(+)

-- 
2.26.2

