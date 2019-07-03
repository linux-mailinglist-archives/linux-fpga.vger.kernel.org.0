Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D0215EB30
	for <lists+linux-fpga@lfdr.de>; Wed,  3 Jul 2019 20:07:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbfGCSH5 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 3 Jul 2019 14:07:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:36274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726574AbfGCSH4 (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 3 Jul 2019 14:07:56 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E29B120659;
        Wed,  3 Jul 2019 18:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562177276;
        bh=ZxI9gMDVDvOvvdaFk/4FqawZmpkLnN9reXrQQEldQl0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fBBCK7og15DSyF/hOj2RnfgNRUSXku173qRIunFe/CHFoGjzefwa0z5F7vH8glKEd
         HFGwlyQ4kUdP+spPljGC3ojj533UJgKIRefjIlVgDprO+HcMoJGxZqLWEb3l+tKlVf
         JDlhw9ig0jIKywgEkhCmI+Pl6STPdn3HaYgXeRBw=
Date:   Wed, 3 Jul 2019 20:07:53 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Moritz Fischer <mdf@kernel.org>
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, Wu Hao <hao.wu@intel.com>,
        Zhang Yi Z <yi.z.zhang@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Alan Tull <atull@kernel.org>
Subject: Re: [PATCH 06/15] fpga: dfl: fme: add
 DFL_FPGA_FME_PORT_RELEASE/ASSIGN ioctl support.
Message-ID: <20190703180753.GA24723@kroah.com>
References: <20190628004951.6202-1-mdf@kernel.org>
 <20190628004951.6202-7-mdf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190628004951.6202-7-mdf@kernel.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Thu, Jun 27, 2019 at 05:49:42PM -0700, Moritz Fischer wrote:
> From: Wu Hao <hao.wu@intel.com>
> 
> In order to support virtualization usage via PCIe SRIOV, this patch
> adds two ioctls under FPGA Management Engine (FME) to release and
> assign back the port device. In order to safely turn Port from PF
> into VF and enable PCIe SRIOV, it requires user to invoke this
> PORT_RELEASE ioctl to release port firstly to remove userspace
> interfaces, and then configure the PF/VF access register in FME.
> After disable SRIOV, it requires user to invoke this PORT_ASSIGN
> ioctl to attach the port back to PF.
> 
>  Ioctl interfaces:
>  * DFL_FPGA_FME_PORT_RELEASE
>    Release platform device of given port, it deletes port platform
>    device to remove related userspace interfaces on PF, then
>    configures PF/VF access mode to VF.
> 
>  * DFL_FPGA_FME_PORT_ASSIGN
>    Assign platform device of given port back to PF, it configures
>    PF/VF access mode to PF, then adds port platform device back to
>    re-enable related userspace interfaces on PF.

Why are you not using the "generic" bind/unbind facility that userspace
already has for this with binding drivers to devices?  Why a special
ioctl?

> --- a/include/uapi/linux/fpga-dfl.h
> +++ b/include/uapi/linux/fpga-dfl.h
> @@ -176,4 +176,36 @@ struct dfl_fpga_fme_port_pr {
>  
>  #define DFL_FPGA_FME_PORT_PR	_IO(DFL_FPGA_MAGIC, DFL_FME_BASE + 0)
>  
> +/**
> + * DFL_FPGA_FME_PORT_RELEASE - _IOW(DFL_FPGA_MAGIC, DFL_FME_BASE + 1,
> + *					struct dfl_fpga_fme_port_release)
> + *
> + * Driver releases the port per Port ID provided by caller.
> + * Return: 0 on success, -errno on failure.
> + */
> +struct dfl_fpga_fme_port_release {
> +	/* Input */
> +	__u32 argsz;		/* Structure length */
> +	__u32 flags;		/* Zero for now */
> +	__u32 port_id;
> +};

meta-comment, why do all of your structures for ioctls have argsz?  You
"know" the size of the structure already, it's part of the ioctl
definition.  You shouldn't need to also set it again, right?  Otherwise
ALL Linux ioctls would need something crazy like this.

thanks,

greg k-h
