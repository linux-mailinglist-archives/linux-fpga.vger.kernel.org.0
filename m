Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD9706DD311
	for <lists+linux-fpga@lfdr.de>; Tue, 11 Apr 2023 08:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230357AbjDKGlU (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 11 Apr 2023 02:41:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230347AbjDKGlK (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 11 Apr 2023 02:41:10 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A21A7100
        for <linux-fpga@vger.kernel.org>; Mon, 10 Apr 2023 23:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681195261; x=1712731261;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=msWl0/tD4R6LRitU6uwLx4yI+PVRYSGDKfJ7WwPwNvc=;
  b=S+uhppCz52iCavSlUlBJy81O71tUgxk4XQLjYsiso9fmVzPqlTgt1WC0
   V9hFxnj17fz0T6W9xUuXQNXwrWxpiWOfDzuQExfzFbAqRNyr8ED56k9++
   CmAm49I/W6/ef8klxKzRP9oXitjcRBNFWh+q6exWrmwGcPpW3fA1/LcEx
   /+LZS6roGH6Slf7FpC4v2RRP9dnvKIqdreyC4bEvsgAhVFqUiwMC5+AWg
   2qUAjnRRn5R+4LxLXzYCGQ2fV0XOcfYTjCicgL2nvFTTVjswHaYvamDbM
   pBUlO6H9ugAAoSv0h2mERNVpqQdbd5Nqzf+d46d9i704LZfM1mX+qiVkf
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="342303663"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="342303663"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2023 23:41:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="638703957"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="638703957"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orsmga003.jf.intel.com with ESMTP; 10 Apr 2023 23:40:59 -0700
Date:   Tue, 11 Apr 2023 14:41:42 +0000
From:   Xu Yilun <yilun.xu@intel.com>
To:     gregkh@linuxfoundation.org
Cc:     yilun.xu@intel.com, linux-fpga@vger.kernel.org, hao.wu@intel.com,
        mdf@kernel.org
Subject: [GIT PULL] FPGA Manager changes for 6.3-final
Message-ID: <ZDVxpv10vXppm8T/@yilunxu-OptiPlex-7050>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DATE_IN_FUTURE_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

The following changes since commit fe15c26ee26efa11741a7b632e9f23b01aca4cc6:

  Linux 6.3-rc1 (2023-03-05 14:52:03 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/fpga/linux-fpga tags/fpga-for-6.3-final

for you to fetch changes up to dc70eb868b9cd2ca01313e5a394e6ea001d513e9:

  fpga: bridge: properly initialize bridge device before populating children (2023-04-07 00:10:04 +0800)

----------------------------------------------------------------
FPGA Manager changes for 6.3-final

Intel m10 bmc secure update:

- Ilpo's change fixes the return value of driver internal function

DFL PCI driver:

- Bjorn's change drops redundant pci_enable_pcie_error_reporting()

Xilinx:

- Michal's change uses xlnx_pr_decouple_read() instead of readl() to
  resolve sparse issue.

FPGA core:

- Alexis's change fixes kernel warning on fpga bridge register

All patches have been reviewed on the mailing list, and have been in the
last linux-next releases (as part of our fixes branch)

Signed-off-by: Xu Yilun <yilun.xu@intel.com>

----------------------------------------------------------------
Alexis Lothoré (1):
      fpga: bridge: properly initialize bridge device before populating children

Bjorn Helgaas (1):
      fpga: dfl-pci: Drop redundant pci_enable_pcie_error_reporting()

Ilpo Järvinen (1):
      fpga: m10bmc-sec: Fix rsu_send_data() to return FW_UPLOAD_ERR_HW_ERROR

Michal Simek (1):
      fpga: xilinx-pr-decoupler: Use readl wrapper instead of pure readl

 drivers/fpga/dfl-pci.c                  | 20 ++++++--------------
 drivers/fpga/fpga-bridge.c              |  3 ++-
 drivers/fpga/intel-m10-bmc-sec-update.c |  2 +-
 drivers/fpga/xilinx-pr-decoupler.c      |  2 +-
 4 files changed, 10 insertions(+), 17 deletions(-)
