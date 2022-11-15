Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98CD0629C21
	for <lists+linux-fpga@lfdr.de>; Tue, 15 Nov 2022 15:29:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbiKOO2P (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 15 Nov 2022 09:28:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231259AbiKOO1p (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 15 Nov 2022 09:27:45 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDEBB2CDCA
        for <linux-fpga@vger.kernel.org>; Tue, 15 Nov 2022 06:27:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668522463; x=1700058463;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=uRm9tE1heb4tBO0OekJMEOmavtEVxP3V0zDIUjnC6wE=;
  b=fQG5hUbdSYvrCG144IzsguMXrDn3+7JVOQQbXwwttir0d2IJ8QhtkNQQ
   36uW0lI4SIS8ive95fWoH6+yZKkg/7bAbZoadDR+GWkEqFz9JKvDOGtgR
   UchwrqOhF+J+3EUGKQVXsGTuT4JfPFpDrazm5vOV6UdoqkzKqN8wspAxK
   cll2mfSrYu9oqIZfVN1vKdT9wOILJoIy5NAqI22jEM2OmG9UGAkYe6Ifd
   BN3M4KDsMhmL2O/Cy/WpwvJT+XLhcs7chlJMU+aqTYewvrXwjHUyNr92z
   fceESHXyBCrhaw0aVyHkmL26WaNf+pd4HHjp4RkS+MaLEKFPvY7USXpnx
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="398553099"
X-IronPort-AV: E=Sophos;i="5.96,166,1665471600"; 
   d="scan'208";a="398553099"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2022 06:27:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="670101525"
X-IronPort-AV: E=Sophos;i="5.96,166,1665471600"; 
   d="scan'208";a="670101525"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orsmga008.jf.intel.com with ESMTP; 15 Nov 2022 06:27:41 -0800
Date:   Tue, 15 Nov 2022 22:18:17 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     gregkh@linuxfoundation.org
Cc:     yilun.xu@intel.com, linux-fpga@vger.kernel.org, hao.wu@intel.com,
        mdf@kernel.org
Subject: [GIT PULL] FPGA Manager changes for 6.2-rc1
Message-ID: <Y3Ofqbmsbn8q4Ksb@yilunxu-OptiPlex-7050>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

The following changes since commit 9abf2313adc1ca1b6180c508c25f22f9395cc780:

  Linux 6.1-rc1 (2022-10-16 15:36:24 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/fpga/linux-fpga tags/fpga-for-6.2-rc1

for you to fetch changes up to ee31d5038c06b56ea515f4fe490274628c0f80e1:

  dt-bindings: fpga: document Lattice sysCONFIG FPGA manager (2022-10-25 14:45:53 +0800)

----------------------------------------------------------------
FPGA Manager changes for 6.2-rc1

Zynq:

- Yang's change Switch to use dev_err_probe() helper

Lattice:

- Ivan's change add support for Lattice Sysconfig FPGA reprogrammer

All patches have been reviewed on the mailing list, and have been in the
last linux-next releases (as part of our for-next branch).

Signed-off-by: Xu Yilun <yilun.xu@intel.com>

----------------------------------------------------------------
Ivan Bornyakov (2):
      fpga: lattice-sysconfig-spi: add Lattice sysCONFIG FPGA manager
      dt-bindings: fpga: document Lattice sysCONFIG FPGA manager

Yang Yingliang (1):
      fpga: zynq: Switch to use dev_err_probe() helper

 .../bindings/fpga/lattice,sysconfig.yaml           |  81 +++++
 drivers/fpga/Kconfig                               |  11 +
 drivers/fpga/Makefile                              |   2 +
 drivers/fpga/lattice-sysconfig-spi.c               | 152 ++++++++
 drivers/fpga/lattice-sysconfig.c                   | 397 +++++++++++++++++++++
 drivers/fpga/lattice-sysconfig.h                   |  39 ++
 drivers/fpga/zynq-fpga.c                           |   8 +-
 7 files changed, 685 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/fpga/lattice,sysconfig.yaml
 create mode 100644 drivers/fpga/lattice-sysconfig-spi.c
 create mode 100644 drivers/fpga/lattice-sysconfig.c
 create mode 100644 drivers/fpga/lattice-sysconfig.h
