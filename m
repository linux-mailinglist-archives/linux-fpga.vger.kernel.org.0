Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A40D06409F
	for <lists+linux-fpga@lfdr.de>; Wed, 10 Jul 2019 07:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726188AbfGJFYg (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 10 Jul 2019 01:24:36 -0400
Received: from mga18.intel.com ([134.134.136.126]:11139 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725932AbfGJFYg (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 10 Jul 2019 01:24:36 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Jul 2019 22:24:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,473,1557212400"; 
   d="scan'208";a="364363437"
Received: from hao-dev.bj.intel.com (HELO localhost) ([10.238.157.65])
  by fmsmga005.fm.intel.com with ESMTP; 09 Jul 2019 22:24:33 -0700
Date:   Wed, 10 Jul 2019 13:07:46 +0800
From:   Wu Hao <hao.wu@intel.com>
To:     gregkh@linuxfoundation.org, mdf@kernel.org,
        linux-fpga@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        atull@kernel.org
Subject: Re: [PATCH v2 00/11] FPGA DFL updates
Message-ID: <20190710050746.GA28620@hao-dev>
References: <1562286238-11413-1-git-send-email-hao.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1562286238-11413-1-git-send-email-hao.wu@intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Fri, Jul 05, 2019 at 08:23:47AM +0800, Wu Hao wrote:
> Hi Greg / Moritz
> 
> This is v2 patchset which adds more features to FPGA DFL. This patchset
> is made on top of patch[1] and char-misc-next tree. Documentation patch
> for DFL is dropped from this patchset, and will resubmit it later to
> avoid conflict.

Hi Greg,

Did you get a chance to take a look at this new version to see if these
patches are good to take?

Hope we can catch up with the merge window.

Thanks
Hao

> 
> Main changes from v1:
>   - remove DRV/MODULE_VERSION modifications. (patch #1, #3, #4, #6)
>   - remove argsz from new ioctls. (patch #2)
>   - replace sysfs_create/remove_* with device_add/remove_* for sysfs entries.
>     (patch #5, #8, #11)
> 
> [1] [PATCH] fpga: dfl: use driver core functions, not sysfs ones.
>     https://lkml.org/lkml/2019/7/4/36
> 
> Wu Hao (11):
>   fpga: dfl: fme: support 512bit data width PR
>   fpga: dfl: fme: add DFL_FPGA_FME_PORT_RELEASE/ASSIGN ioctl support.
>   fpga: dfl: pci: enable SRIOV support.
>   fpga: dfl: afu: add AFU state related sysfs interfaces
>   fpga: dfl: afu: add userclock sysfs interfaces.
>   fpga: dfl: add id_table for dfl private feature driver
>   fpga: dfl: afu: export __port_enable/disable function.
>   fpga: dfl: afu: add error reporting support.
>   fpga: dfl: afu: add STP (SignalTap) support
>   fpga: dfl: fme: add capability sysfs interfaces
>   fpga: dfl: fme: add global error reporting support
> 
>  Documentation/ABI/testing/sysfs-platform-dfl-fme  |  98 ++++++
>  Documentation/ABI/testing/sysfs-platform-dfl-port | 104 ++++++
>  drivers/fpga/Makefile                             |   3 +-
>  drivers/fpga/dfl-afu-error.c                      | 225 +++++++++++++
>  drivers/fpga/dfl-afu-main.c                       | 328 +++++++++++++++++-
>  drivers/fpga/dfl-afu.h                            |   7 +
>  drivers/fpga/dfl-fme-error.c                      | 385 ++++++++++++++++++++++
>  drivers/fpga/dfl-fme-main.c                       |  93 +++++-
>  drivers/fpga/dfl-fme-mgr.c                        | 110 ++++++-
>  drivers/fpga/dfl-fme-pr.c                         |  50 ++-
>  drivers/fpga/dfl-fme.h                            |   7 +-
>  drivers/fpga/dfl-pci.c                            |  39 +++
>  drivers/fpga/dfl.c                                | 166 +++++++++-
>  drivers/fpga/dfl.h                                |  54 ++-
>  include/uapi/linux/fpga-dfl.h                     |  19 ++
>  15 files changed, 1617 insertions(+), 71 deletions(-)
>  create mode 100644 drivers/fpga/dfl-afu-error.c
>  create mode 100644 drivers/fpga/dfl-fme-error.c
> 
> -- 
> 1.8.3.1
