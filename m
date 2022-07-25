Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFE0457FC78
	for <lists+linux-fpga@lfdr.de>; Mon, 25 Jul 2022 11:34:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232148AbiGYJc0 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 25 Jul 2022 05:32:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbiGYJcZ (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 25 Jul 2022 05:32:25 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79C5913E8A
        for <linux-fpga@vger.kernel.org>; Mon, 25 Jul 2022 02:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658741544; x=1690277544;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=AEr/pSHtxZNbSuzOA4DYvC/HtKpcHsvUZHflaesxHuI=;
  b=dlVQTZ4m9qqyZH9a0QRynIy5qn77OktYZwETeClrlfXtT61wcjbmKtEh
   7TDPoWx42JjCNAgeXAzffITXOsSBk+T1i02lMNzU8AYtKWW/qV13jbLSX
   cdy7aUSwzhL/V0FuTftrKICVWKo4m5cnGZanCQ63o1boJAKtxWgLJejuf
   u8lSP4JiqkqMUniA2lK0rLz2tp1dsWCP47m+Xb2e8qnB58B2JL79rwsph
   njuVcIL/n+Y/69lTdgZfn5xrDuea/IqXg+Z5yo5B2wQB0dk+zQRZIYrpT
   AeiXMcAOwlYnuoweiwU7K2lWcF4VxWrr76x/pcljXeG20DE/GS+IHGiui
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10418"; a="286414809"
X-IronPort-AV: E=Sophos;i="5.93,192,1654585200"; 
   d="scan'208";a="286414809"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2022 02:32:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,192,1654585200"; 
   d="scan'208";a="667421097"
Received: from unknown (HELO localhost.localdomain.sh.intel.com) ([10.238.175.107])
  by fmsmga004.fm.intel.com with ESMTP; 25 Jul 2022 02:32:22 -0700
From:   Tianfei Zhang <tianfei.zhang@intel.com>
To:     mdf@kernel.org, yilun.xu@intel.com, linux-fpga@vger.kernel.org,
        lee.jones@linaro.org, russell.h.weight@intel.com
Cc:     hao.wu@intel.com, trix@redhat.com,
        Tianfei Zhang <tianfei.zhang@intel.com>
Subject: [PATCH v2 0/3] add Intel FPGA image reload support
Date:   Mon, 25 Jul 2022 05:28:33 -0400
Message-Id: <20220725092836.647028-1-tianfei.zhang@intel.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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

patch 1: add register access helper functions for M10BMC.
patch 2: add the available_images and image_load sysfs files.
Write a key word into image_load sysfs file to trigger a reload of an
FPGA, BMC, or firmware image from FLASH or EEPROM.
patch 3: add a trigger to update a new Retimer firmware.

v2:
add more detail about how to use the image_load sysfs files in ABI
documentation.

Russ Weight (2):
  fpga: m10bmc-sec: add sysfs to reload FPGA/BMC images
  fpga: m10bmc-sec: add m10bmc_sec_retimer_load callback

Tianfei Zhang (1):
  mfd: intel-m10-bmc: add m10bmc_sys_update_bits API

 .../sysfs-driver-intel-m10-bmc-sec-update     |  34 +++
 drivers/fpga/intel-m10-bmc-sec-update.c       | 250 ++++++++++++++++++
 include/linux/mfd/intel-m10-bmc.h             |  49 ++++
 3 files changed, 333 insertions(+)

-- 
2.26.2

