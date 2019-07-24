Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D185672B81
	for <lists+linux-fpga@lfdr.de>; Wed, 24 Jul 2019 11:35:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbfGXJff (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 24 Jul 2019 05:35:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:35052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726351AbfGXJff (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 24 Jul 2019 05:35:35 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0181D21926;
        Wed, 24 Jul 2019 09:35:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563960934;
        bh=u3fLxCqoYEzLtx7mnMt6QJnsljDN0DTqmQi0kpcJWX4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YQdW87uTeCavnpBBnSMCkfEnRcNrQpRxKUB1Er6v2sYpRV1ZSQNph+QTf/uPjD9d0
         62mNhwJ/2I+cgug0PoCy19/2IVEHZPNcRdxMe++yIpcz8SYuI/izE2mAme+DaBeFvp
         ob34XC0cYxVn/S0MwoGpRJc89mToJZ/llvV6JfZE=
Date:   Wed, 24 Jul 2019 11:35:32 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Wu Hao <hao.wu@intel.com>
Cc:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org, atull@kernel.org,
        Ananda Ravuri <ananda.ravuri@intel.com>,
        Xu Yilun <yilun.xu@intel.com>
Subject: Re: [PATCH v3 01/12] fpga: dfl: fme: support 512bit data width PR
Message-ID: <20190724093532.GB29532@kroah.com>
References: <1563857495-26692-1-git-send-email-hao.wu@intel.com>
 <1563857495-26692-2-git-send-email-hao.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1563857495-26692-2-git-send-email-hao.wu@intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Tue, Jul 23, 2019 at 12:51:24PM +0800, Wu Hao wrote:
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
> v2: remove DRV/MODULE_VERSION modifications
> ---
>  drivers/fpga/dfl-fme-mgr.c | 110 ++++++++++++++++++++++++++++++++++++++-------
>  drivers/fpga/dfl-fme-pr.c  |  43 +++++++++++-------
>  drivers/fpga/dfl-fme.h     |   2 +
>  drivers/fpga/dfl.h         |   5 +++
>  4 files changed, 129 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/fpga/dfl-fme-mgr.c b/drivers/fpga/dfl-fme-mgr.c
> index b3f7eee..46e17f0 100644
> --- a/drivers/fpga/dfl-fme-mgr.c
> +++ b/drivers/fpga/dfl-fme-mgr.c
> @@ -22,6 +22,7 @@
>  #include <linux/io-64-nonatomic-lo-hi.h>
>  #include <linux/fpga/fpga-mgr.h>
>  
> +#include "dfl.h"
>  #include "dfl-fme-pr.h"
>  
>  /* FME Partial Reconfiguration Sub Feature Register Set */
> @@ -30,6 +31,7 @@
>  #define FME_PR_STS		0x10
>  #define FME_PR_DATA		0x18
>  #define FME_PR_ERR		0x20
> +#define FME_PR_512_DATA		0x40 /* Data Register for 512bit datawidth PR */
>  #define FME_PR_INTFC_ID_L	0xA8
>  #define FME_PR_INTFC_ID_H	0xB0
>  
> @@ -67,8 +69,43 @@
>  #define PR_WAIT_TIMEOUT   8000000
>  #define PR_HOST_STATUS_IDLE	0
>  
> +#if defined(CONFIG_X86) && defined(CONFIG_AS_AVX512)
> +
> +#include <linux/cpufeature.h>
> +#include <asm/fpu/api.h>
> +
> +static inline int is_cpu_avx512_enabled(void)
> +{
> +	return cpu_feature_enabled(X86_FEATURE_AVX512F);
> +}

That's a very arch specific function, why would a driver ever care about
this?

> +
> +static inline void copy512(const void *src, void __iomem *dst)
> +{
> +	kernel_fpu_begin();
> +
> +	asm volatile("vmovdqu64 (%0), %%zmm0;"
> +		     "vmovntdq %%zmm0, (%1);"
> +		     :
> +		     : "r"(src), "r"(dst)
> +		     : "memory");
> +
> +	kernel_fpu_end();
> +}

Shouldn't this be an arch-specific function somewhere?  Burying this in
a random driver is not ok.  Please make this generic for all systems.

> +#else
> +static inline int is_cpu_avx512_enabled(void)
> +{
> +	return 0;
> +}
> +
> +static inline void copy512(const void *src, void __iomem *dst)
> +{
> +	WARN_ON_ONCE(1);

Are you trying to get reports from syzbot?  :)

Please fix this all up.

greg k-h
