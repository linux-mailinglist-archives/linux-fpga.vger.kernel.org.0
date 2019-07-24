Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B54E731DB
	for <lists+linux-fpga@lfdr.de>; Wed, 24 Jul 2019 16:39:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728225AbfGXOjg (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 24 Jul 2019 10:39:36 -0400
Received: from mga18.intel.com ([134.134.136.126]:37257 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725870AbfGXOjg (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 24 Jul 2019 10:39:36 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Jul 2019 07:39:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,303,1559545200"; 
   d="scan'208";a="197519558"
Received: from hao-dev.bj.intel.com (HELO localhost) ([10.238.157.65])
  by fmsmga002.fm.intel.com with ESMTP; 24 Jul 2019 07:39:32 -0700
Date:   Wed, 24 Jul 2019 22:22:35 +0800
From:   Wu Hao <hao.wu@intel.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org, atull@kernel.org,
        Ananda Ravuri <ananda.ravuri@intel.com>,
        Xu Yilun <yilun.xu@intel.com>
Subject: Re: [PATCH v3 01/12] fpga: dfl: fme: support 512bit data width PR
Message-ID: <20190724142235.GE8463@hao-dev>
References: <1563857495-26692-1-git-send-email-hao.wu@intel.com>
 <1563857495-26692-2-git-send-email-hao.wu@intel.com>
 <20190724093532.GB29532@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190724093532.GB29532@kroah.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Wed, Jul 24, 2019 at 11:35:32AM +0200, Greg KH wrote:
> On Tue, Jul 23, 2019 at 12:51:24PM +0800, Wu Hao wrote:
> > In early partial reconfiguration private feature, it only
> > supports 32bit data width when writing data to hardware for
> > PR. 512bit data width PR support is an important optimization
> > for some specific solutions (e.g. XEON with FPGA integrated),
> > it allows driver to use AVX512 instruction to improve the
> > performance of partial reconfiguration. e.g. programming one
> > 100MB bitstream image via this 512bit data width PR hardware
> > only takes ~300ms, but 32bit revision requires ~3s per test
> > result.
> > 
> > Please note now this optimization is only done on revision 2
> > of this PR private feature which is only used in integrated
> > solution that AVX512 is always supported. This revision 2
> > hardware doesn't support 32bit PR.
> > 
> > Signed-off-by: Ananda Ravuri <ananda.ravuri@intel.com>
> > Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> > Signed-off-by: Wu Hao <hao.wu@intel.com>
> > Acked-by: Alan Tull <atull@kernel.org>
> > Signed-off-by: Moritz Fischer <mdf@kernel.org>
> > ---
> > v2: remove DRV/MODULE_VERSION modifications
> > ---
> >  drivers/fpga/dfl-fme-mgr.c | 110 ++++++++++++++++++++++++++++++++++++++-------
> >  drivers/fpga/dfl-fme-pr.c  |  43 +++++++++++-------
> >  drivers/fpga/dfl-fme.h     |   2 +
> >  drivers/fpga/dfl.h         |   5 +++
> >  4 files changed, 129 insertions(+), 31 deletions(-)
> > 
> > diff --git a/drivers/fpga/dfl-fme-mgr.c b/drivers/fpga/dfl-fme-mgr.c
> > index b3f7eee..46e17f0 100644
> > --- a/drivers/fpga/dfl-fme-mgr.c
> > +++ b/drivers/fpga/dfl-fme-mgr.c
> > @@ -22,6 +22,7 @@
> >  #include <linux/io-64-nonatomic-lo-hi.h>
> >  #include <linux/fpga/fpga-mgr.h>
> >  
> > +#include "dfl.h"
> >  #include "dfl-fme-pr.h"
> >  
> >  /* FME Partial Reconfiguration Sub Feature Register Set */
> > @@ -30,6 +31,7 @@
> >  #define FME_PR_STS		0x10
> >  #define FME_PR_DATA		0x18
> >  #define FME_PR_ERR		0x20
> > +#define FME_PR_512_DATA		0x40 /* Data Register for 512bit datawidth PR */
> >  #define FME_PR_INTFC_ID_L	0xA8
> >  #define FME_PR_INTFC_ID_H	0xB0
> >  
> > @@ -67,8 +69,43 @@
> >  #define PR_WAIT_TIMEOUT   8000000
> >  #define PR_HOST_STATUS_IDLE	0
> >  
> > +#if defined(CONFIG_X86) && defined(CONFIG_AS_AVX512)
> > +
> > +#include <linux/cpufeature.h>
> > +#include <asm/fpu/api.h>
> > +
> > +static inline int is_cpu_avx512_enabled(void)
> > +{
> > +	return cpu_feature_enabled(X86_FEATURE_AVX512F);
> > +}
> 
> That's a very arch specific function, why would a driver ever care about
> this?

Yes, this is only applied to a specific FPGA solution, which FPGA
has been integrated with XEON. Hardware indicates this using register
to software. As it's cpu integrated solution, so CPU always has this
AVX512 capability. The only check we do, is make sure this is not
manually disabled by kernel.

With this hardware, software could use AVX512 to accelerate the FPGA
partial reconfiguration as mentioned in the patch commit message.
It brings performance benifits to people who uses it. This is only one
optimization (512 vs 32bit data write to hw) for a specific hardware.

For other discrete solutions, e.g. FPGA PCIe Card, this is not used
at all as driver does check hardware register to avoid any AVX512 code.

> 
> > +
> > +static inline void copy512(const void *src, void __iomem *dst)
> > +{
> > +	kernel_fpu_begin();
> > +
> > +	asm volatile("vmovdqu64 (%0), %%zmm0;"
> > +		     "vmovntdq %%zmm0, (%1);"
> > +		     :
> > +		     : "r"(src), "r"(dst)
> > +		     : "memory");
> > +
> > +	kernel_fpu_end();
> > +}
> 
> Shouldn't this be an arch-specific function somewhere?  Burying this in
> a random driver is not ok.  Please make this generic for all systems.

If more people need the same avx operation like this in kernel, then maybe
this can be moved to some arch-specific lib code somewhere as some common
functions to everybody, but i am not very sure if this is the case. Let me
think about this more.

> 
> > +#else
> > +static inline int is_cpu_avx512_enabled(void)
> > +{
> > +	return 0;
> > +}
> > +
> > +static inline void copy512(const void *src, void __iomem *dst)
> > +{
> > +	WARN_ON_ONCE(1);
> 
> Are you trying to get reports from syzbot?  :)

Oh.. no.. I will remove it. :)

Thank you very much!

Hao

> 
> Please fix this all up.
> 
> greg k-h
