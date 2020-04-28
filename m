Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 130711BB5A6
	for <lists+linux-fpga@lfdr.de>; Tue, 28 Apr 2020 07:04:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726334AbgD1FE1 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 28 Apr 2020 01:04:27 -0400
Received: from mga14.intel.com ([192.55.52.115]:10411 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726042AbgD1FE1 (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 28 Apr 2020 01:04:27 -0400
IronPort-SDR: st8HWoiB/PiRtIxcsMIZZ+y6+xK/NiJnBbQRq2/c7UDIRubmDoh0s3+RwqOFosOVAiVdoEpiQ9
 W5HBQticXTGw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2020 22:04:26 -0700
IronPort-SDR: iPxTFM3ev1MWeMRC4aiL1oaNO47gnWGI3rOc8ZJrQ92tzn+Uf/L/rHO+D2h+9Xn5ybqKGfqhVk
 cxEq5b450dog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,326,1583222400"; 
   d="scan'208";a="302607777"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.141])
  by FMSMGA003.fm.intel.com with ESMTP; 27 Apr 2020 22:04:25 -0700
Date:   Tue, 28 Apr 2020 13:01:35 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     linux-fpga@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mdf@kernel.org
Subject: How to update a piece of flash for FPGA firmware?
Message-ID: <20200428050135.GA27416@yilunxu-OptiPlex-7050>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi,

I wonder if an updating of FPGA Flash (but cannot reload) could be
implemented as fpga-mgr?

I have the pcie based FPGA card. The bitstream for FPGA static region is
stored on flash chip. Board will load the bitstream to FPGA on system
power cycle. The flash chip could be accessed through "PCIE -> ... ->
Flash update engine -> Flash". So the update of the FPGA static region is
basicly updating the flash chip through PCIE and rebooting system.

Should I implement the flash update engine as a fpga-mgr device? On one
hand it is just a flash write, FPGA functionality is actually not
changed before reboot. Does fpga-mgr requires bitstream takes function
immediately after write_complete()? On the other hand, the flash write
do affects FPGA static region on next boot. Operating on the
corresponding fpga region makes kernel fully aware of what is being
done.

Actually the FPGA card do has the capability to reload bitstream at
runtime. But it will cause the whole PCIE device lost, static region is
also destroyed. We need to rescan PCI to get it back. So I think
basically this is the same case as system reboot from FPGA's
perspective.

Thanks
Yilun
