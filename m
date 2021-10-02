Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29C3741FC9F
	for <lists+linux-fpga@lfdr.de>; Sat,  2 Oct 2021 16:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233429AbhJBO56 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 2 Oct 2021 10:57:58 -0400
Received: from mga17.intel.com ([192.55.52.151]:30472 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229560AbhJBO56 (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Sat, 2 Oct 2021 10:57:58 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10125"; a="205849320"
X-IronPort-AV: E=Sophos;i="5.85,342,1624345200"; 
   d="scan'208";a="205849320"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2021 07:56:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,341,1624345200"; 
   d="scan'208";a="620015059"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.162])
  by fmsmga001.fm.intel.com with ESMTP; 02 Oct 2021 07:56:11 -0700
Date:   Sat, 2 Oct 2021 22:49:57 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Moritz Fischer <mdf@kernel.org>
Cc:     linux-fpga@vger.kernel.org, moritzf@google.com,
        Wu Hao <hao.wu@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 2/2] MAINTAINERS: Drop outdated FPGA Manager website
Message-ID: <20211002144957.GA53209@yilunxu-OptiPlex-7050>
References: <20210928150227.22275-1-mdf@kernel.org>
 <20210928150227.22275-2-mdf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210928150227.22275-2-mdf@kernel.org>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Tue, Sep 28, 2021 at 08:02:26AM -0700, Moritz Fischer wrote:
> The rocketboards website no longer really reflects a good landing
> place for people interested in FPGA Manager.
> 
> Cc: Xu Yilun <yilun.xu@intel.com>
> Cc: Wu Hao <hao.wu@intel.com>
> Signed-off-by: Moritz Fischer <mdf@kernel.org>
> ---
>  MAINTAINERS | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2ec4c2a2458a..c4eaac287edb 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7342,7 +7342,6 @@ M:	Xu Yilun <yilun.xu@intel.com>
>  R:	Tom Rix <trix@redhat.com>
>  L:	linux-fpga@vger.kernel.org
>  S:	Maintained
> -W:	http://www.rocketboards.org

The website is mostly about SOCFPGA architecture, while the FPGA Manager
is mainly about the generic image loading and enumeration framework. So
I'm good to this change.

People could still find the website at ARM/SOCFPGA ARCHITECTURE, which is a
better place for it.

Acked-by: Xu Yilun <yilun.xu@intel.com>

Thanks,
Yilun

>  Q:	http://patchwork.kernel.org/project/linux-fpga/list/
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mdf/linux-fpga.git
>  F:	Documentation/devicetree/bindings/fpga/
> -- 
> 2.33.0
