Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F43D5EAF7
	for <lists+linux-fpga@lfdr.de>; Wed,  3 Jul 2019 19:56:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbfGCR4F (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 3 Jul 2019 13:56:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:53136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726430AbfGCR4F (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 3 Jul 2019 13:56:05 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 984D62184C;
        Wed,  3 Jul 2019 17:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562176564;
        bh=L3h7wwKgvwILQUaF8E4p9qXMhfRYyp+VoJCbvfQ0d1I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EamyrQd6SFdTCUkrd3JVNgORmJpot8kSicTmfnpNtpOFgou59PJYhclDTX4yMTVqb
         Ei9nKrIVWVRliYzhfwVexZKisw9hktv8CpdGtuQNCjOKe6PHFxEu0UDaRHO2egUJLM
         Qkeg35NPByPrcSazHY1rb7beXr4SY+zY5qWMwZJQ=
Date:   Wed, 3 Jul 2019 19:56:01 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Moritz Fischer <mdf@kernel.org>
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, Wu Hao <hao.wu@intel.com>,
        Ananda Ravuri <ananda.ravuri@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Alan Tull <atull@kernel.org>
Subject: Re: [PATCH 04/15] fpga: dfl: fme: support 512bit data width PR
Message-ID: <20190703175601.GA14034@kroah.com>
References: <20190628004951.6202-1-mdf@kernel.org>
 <20190628004951.6202-5-mdf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190628004951.6202-5-mdf@kernel.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Thu, Jun 27, 2019 at 05:49:40PM -0700, Moritz Fischer wrote:
> From: Wu Hao <hao.wu@intel.com>
> 
> In early partial reconfiguration private feature, it only
> supports 32bit data width when writing data to hardware for
> PR. 512bit data width PR support is an important optimization
> for some specific solutions (e.g. XEON with FPGA integrated),
> it allows driver to use AVX512 instruction to improve the
> performance of partial reconfiguration. e.g. programming one
> 100MB bitstream image via this 512bit data width PR hardware
> only takes ~300ms, but 32bit revision requires ~3s per test
> result.
> 
> Please note now this optimization is only done on revision 2
> of this PR private feature which is only used in integrated
> solution that AVX512 is always supported. This revision 2
> hardware doesn't support 32bit PR.
> 
> Signed-off-by: Ananda Ravuri <ananda.ravuri@intel.com>
> Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> Signed-off-by: Wu Hao <hao.wu@intel.com>
> Acked-by: Alan Tull <atull@kernel.org>
> Signed-off-by: Moritz Fischer <mdf@kernel.org>
> ---
>  drivers/fpga/dfl-fme-main.c |   3 +
>  drivers/fpga/dfl-fme-mgr.c  | 113 +++++++++++++++++++++++++++++++-----
>  drivers/fpga/dfl-fme-pr.c   |  43 +++++++++-----
>  drivers/fpga/dfl-fme.h      |   2 +
>  drivers/fpga/dfl.h          |   5 ++
>  5 files changed, 135 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/fpga/dfl-fme-main.c b/drivers/fpga/dfl-fme-main.c
> index 086ad2420ade..076d74f6416d 100644
> --- a/drivers/fpga/dfl-fme-main.c
> +++ b/drivers/fpga/dfl-fme-main.c
> @@ -21,6 +21,8 @@
>  #include "dfl.h"
>  #include "dfl-fme.h"
>  
> +#define DRV_VERSION	"0.8"
> +
>  static ssize_t ports_num_show(struct device *dev,
>  			      struct device_attribute *attr, char *buf)
>  {
> @@ -277,3 +279,4 @@ MODULE_DESCRIPTION("FPGA Management Engine driver");
>  MODULE_AUTHOR("Intel Corporation");
>  MODULE_LICENSE("GPL v2");
>  MODULE_ALIAS("platform:dfl-fme");
> +MODULE_VERSION(DRV_VERSION);

No, we ripped out these useless "driver version" things all over the
place, please do not add them back in again.  They mean nothing and
confuse people to no end.

I'll not take this patch, sorry.

greg k-h
