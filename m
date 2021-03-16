Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5831033CCFF
	for <lists+linux-fpga@lfdr.de>; Tue, 16 Mar 2021 06:15:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231877AbhCPFPS (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 16 Mar 2021 01:15:18 -0400
Received: from mga11.intel.com ([192.55.52.93]:65211 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229880AbhCPFO5 (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 16 Mar 2021 01:14:57 -0400
IronPort-SDR: TvuJBqcQ7t1yp1powMOsAMtRLhGf2GTMjHdGLY1mdGzjzW1JYEF7pTm9SA0QvAI+IeBWgg7ZgT
 5Wl2i/OafSwg==
X-IronPort-AV: E=McAfee;i="6000,8403,9924"; a="185842038"
X-IronPort-AV: E=Sophos;i="5.81,251,1610438400"; 
   d="scan'208";a="185842038"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2021 22:14:57 -0700
IronPort-SDR: s/Dg9UnRkeYdhS+2SmeU2B50FjEgcPPmSMzgPymdFTiRacMV1KpiK7qwCnd3VL4/STlfSlvKAP
 8j4niG7vgOzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,251,1610438400"; 
   d="scan'208";a="601701432"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.141])
  by fmsmga006.fm.intel.com with ESMTP; 15 Mar 2021 22:14:55 -0700
Date:   Tue, 16 Mar 2021 13:10:05 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     gregkh@linuxfoundation.org, mdf@kernel.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, lgoncalv@redhat.com, hao.wu@intel.com,
        yilun.xu@intel.com
Subject: Re: [PATCH v12 0/2] UIO support for dfl devices
Message-ID: <20210316051005.GA461@yilunxu-OptiPlex-7050>
References: <1615168776-8553-1-git-send-email-yilun.xu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1615168776-8553-1-git-send-email-yilun.xu@intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Greg:

I listed below some answers from Moritz and Yilun from previous mails for
your question.

Do you have more comments?

Thanks in advance,
Yilun

On Mon, Mar 08, 2021 at 09:59:34AM +0800, Xu Yilun wrote:
> This patchset supports some dfl device drivers written in userspace.
> 
> There are some Q&A about why UIO driver is needed in v11:
> 
> >From Greg:
>   Why are you saying that an ethernet driver should be using the UIO
>   interface?
> 
>   And why can't you use the existing UIO drivers that bind to memory
>   regions specified by firmware?  Without an interrupt being used, why is
>   UIO needed at all?
> 
> >From Moritz:
>   Essentially I see two options:
>   - Have a DFL bus driver instantiate a platform driver (uio_pdrv_genirq)
>     which I *think* you described above?
>   - What this patch implements -- a UIO driver on the DFL bus
> 
>   These FPGA devices can on the fly change their contents and -- even if
>   just for test -- being able to expose a bunch of registers via UIO can
>   be extremely useful.
> 
>   Whether a device should expose registers or not should be up to the
>   implemeneter of the FPGA design I think (policy). This patch (or the
>   previous version) provides a mechanism to do so via DFL.
> 
>   This is similar in nature to uio_pdrv_genirq on a DT based platform, to
>   expose the registers you instantiate the DT node.
> 
>   Re-implementing a new driver for each of these instances doesn't seem
>   desirable and tying DFL as enumeration mechanism to UIO seems like a
>   good compromise for enabling this kind of functionality.
> 
>   Note this is *not* an attempt to bypass the network stack or other
>   existing subsystems.
> 
> See the original message in:
>   https://lore.kernel.org/linux-fpga/YDvQ8aO8v3NhLKzx@epycbox.lan/T/#m66ba2c96848e3dea38d1a4f16dfea3cb291f7975
> 
> 
> >From Yilun:
>   The ETH GROUP IP is not designed as the full functional ethernet
>   controller. It is specially developed for the Intel N3000 NIC. Since it
>   is an FPGA based card, it is designed for the users to runtime reload
>   part of the MAC layer logic developed by themselves, while the ETH GROUP
>   is another part of the MAC which is not expected to be reloaded by
>   customers, but it provides some configurations for software to work with
>   the user logic.
> 
>   So I category the feature as the devices that "designed for specific
>   purposes and does not fit into one of the standard kernel subsystems".
>   Some related description could be found in Patch #2, to illustrate why
>   using UIO for some DFL devices.
> 
>   There are now UIO drivers for PCI or platform devices, but in this case
>   we are going to export a DFL(Device Feature List) bus device to
>   userspace, a DFL driver for UIO is needed to bind to it.
> 
> See the original message in:
>   https://lore.kernel.org/linux-fpga/YDvQ8aO8v3NhLKzx@epycbox.lan/T/#m91b303fd61485644353fad1e1e9c11d528844684
> 
> 
> Xu Yilun (2):
>   uio: uio_dfl: add userspace i/o driver for DFL bus
>   Documentation: fpga: dfl: Add description for DFL UIO support
> 
>  Documentation/fpga/dfl.rst | 26 ++++++++++++++++++
>  MAINTAINERS                |  1 +
>  drivers/uio/Kconfig        | 17 ++++++++++++
>  drivers/uio/Makefile       |  1 +
>  drivers/uio/uio_dfl.c      | 66 ++++++++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 111 insertions(+)
>  create mode 100644 drivers/uio/uio_dfl.c
> 
> -- 
> 2.7.4
