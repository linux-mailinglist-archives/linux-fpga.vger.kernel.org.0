Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62ACC8E376
	for <lists+linux-fpga@lfdr.de>; Thu, 15 Aug 2019 06:15:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726229AbfHOEPV (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 15 Aug 2019 00:15:21 -0400
Received: from mga04.intel.com ([192.55.52.120]:58501 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725875AbfHOEPU (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 15 Aug 2019 00:15:20 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Aug 2019 21:15:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,387,1559545200"; 
   d="scan'208";a="184514859"
Received: from hao-dev.bj.intel.com (HELO localhost) ([10.238.157.65])
  by FMSMGA003.fm.intel.com with ESMTP; 14 Aug 2019 21:15:18 -0700
Date:   Thu, 15 Aug 2019 11:58:04 +0800
From:   Wu Hao <hao.wu@intel.com>
To:     Scott Wood <swood@redhat.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, mdf@kernel.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-doc@vger.kernel.org,
        atull@kernel.org, Ananda Ravuri <ananda.ravuri@intel.com>,
        Xu Yilun <yilun.xu@intel.com>
Subject: Re: [PATCH v3 01/12] fpga: dfl: fme: support 512bit data width PR
Message-ID: <20190815035804.GA29090@hao-dev>
References: <1563857495-26692-1-git-send-email-hao.wu@intel.com>
 <1563857495-26692-2-git-send-email-hao.wu@intel.com>
 <20190724093532.GB29532@kroah.com>
 <20190724142235.GE8463@hao-dev>
 <32c46e3de1a6641eb0d5940868f7d8b8a30181d3.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32c46e3de1a6641eb0d5940868f7d8b8a30181d3.camel@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Wed, Aug 14, 2019 at 11:34:15AM -0500, Scott Wood wrote:
> On Wed, 2019-07-24 at 22:22 +0800, Wu Hao wrote:
> > On Wed, Jul 24, 2019 at 11:35:32AM +0200, Greg KH wrote:
> > > On Tue, Jul 23, 2019 at 12:51:24PM +0800, Wu Hao wrote:
> > > >  
> > > > @@ -67,8 +69,43 @@
> > > >  #define PR_WAIT_TIMEOUT   8000000
> > > >  #define PR_HOST_STATUS_IDLE	0
> > > >  
> > > > +#if defined(CONFIG_X86) && defined(CONFIG_AS_AVX512)
> > > > +
> > > > +#include <linux/cpufeature.h>
> > > > +#include <asm/fpu/api.h>
> > > > +
> > > > +static inline int is_cpu_avx512_enabled(void)
> > > > +{
> > > > +	return cpu_feature_enabled(X86_FEATURE_AVX512F);
> > > > +}
> > > 
> > > That's a very arch specific function, why would a driver ever care about
> > > this?
> > 
> > Yes, this is only applied to a specific FPGA solution, which FPGA
> > has been integrated with XEON. Hardware indicates this using register
> > to software. As it's cpu integrated solution, so CPU always has this
> > AVX512 capability. The only check we do, is make sure this is not
> > manually disabled by kernel.
> > 
> > With this hardware, software could use AVX512 to accelerate the FPGA
> > partial reconfiguration as mentioned in the patch commit message.
> > It brings performance benifits to people who uses it. This is only one
> > optimization (512 vs 32bit data write to hw) for a specific hardware.
> 
> I thought earlier you said that 512 bit accesses were required for this
> particular integrated-only version of the device, and not just an
> optimization?

yes, some optimization implemented in a specific integrated-only version
of hardware, this patch is used to support that particular hardware. This
is also the reason you see code here to check hardware revision in this
patch.

> 
> > > > +#else
> > > > +static inline int is_cpu_avx512_enabled(void)
> > > > +{
> > > > +	return 0;
> > > > +}
> > > > +
> > > > +static inline void copy512(const void *src, void __iomem *dst)
> > > > +{
> > > > +	WARN_ON_ONCE(1);
> > > 
> > > Are you trying to get reports from syzbot?  :)
> > 
> > Oh.. no.. I will remove it. :)
> > 
> > Thank you very much!
> 
> What's wrong with this?  The driver should never call copy512() if
> is_cpu_avx512_enabled() returns 0, and if syzbot can somehow make the driver
> do so, then yes we do want a report.

Yes, you are right, in previous version, it doesn't have avx512 enable check
there, so it's possible to have false reporting, it should be fine after
driver does early check on this during probe. As this patch has been dropped
from main patchset, may rework it later and resubmit. Thanks for the comments.

Hao

> 
> -Scott
> 
