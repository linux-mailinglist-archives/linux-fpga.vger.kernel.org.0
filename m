Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EED453A10C9
	for <lists+linux-fpga@lfdr.de>; Wed,  9 Jun 2021 12:49:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238548AbhFIKCg (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 9 Jun 2021 06:02:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:45236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236044AbhFIKCg (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 9 Jun 2021 06:02:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 61E986128A;
        Wed,  9 Jun 2021 10:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1623232841;
        bh=IrNl7vfYlp+saZHXReXLrhcdAC1w3K2DQvXRBiZoqE4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1BOCOjMr/rJivnL5uoCS+hChPU6Hs9/5OpwrwnY6ZIDDKPOy+BFK2Ch460O+JcniA
         C9jPf3kC6NRCFFhISSDMPa3sAciPL4t1dy35eVu4rrd53EVRwa3vUAT+dn/6za47LV
         pFEKGY1X8QjnGTRPQdZPWHsjiFH8MGNpgr5HTuNo=
Date:   Wed, 9 Jun 2021 12:00:38 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     trix@redhat.com
Cc:     hao.wu@intel.com, mdf@kernel.org, corbet@lwn.net,
        michal.simek@xilinx.com, dinguyen@kernel.org,
        krzysztof.kozlowski@canonical.com, nava.manne@xilinx.com,
        yilun.xu@intel.com, davidgow@google.com, fpacheco@redhat.com,
        richard.gong@intel.com, luca@lucaceresoli.net,
        linux-fpga@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/7] fpga: reorganize to subdirs
Message-ID: <YMCRRm/lB2+gfpS9@kroah.com>
References: <20210608162340.3010204-1-trix@redhat.com>
 <20210608162340.3010204-2-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210608162340.3010204-2-trix@redhat.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Tue, Jun 08, 2021 at 09:23:33AM -0700, trix@redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
> 
> The incoming xrt patchset has a toplevel subdir xrt/
> The current fpga/ uses a single dir with filename prefixes to subdivide owners
> For consistency, there should be only one way to organize the fpga/ dir.
> Because the subdir model scales better, refactor to use it.
> The discussion wrt xrt is here:
> https://lore.kernel.org/linux-fpga/68e85a4f-4a10-1ff9-0443-aa565878c855@redhat.com/
> 
> Follow drivers/net/ethernet/ which has control configs
> NET_VENDOR_BLA that map to drivers/net/ethernet/bla
> Since fpgas do not have many vendors, drop the 'VENDOR' and use
> FPGA_BLA.

Why did we get two 0/7 emails?

confused,

greg k-h
