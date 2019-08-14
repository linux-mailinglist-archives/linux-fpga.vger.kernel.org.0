Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69EDD8D826
	for <lists+linux-fpga@lfdr.de>; Wed, 14 Aug 2019 18:34:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726126AbfHNQeR (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 14 Aug 2019 12:34:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46208 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726047AbfHNQeR (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 14 Aug 2019 12:34:17 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2E4D431752BD;
        Wed, 14 Aug 2019 16:34:17 +0000 (UTC)
Received: from ovpn-117-150.phx2.redhat.com (ovpn-117-150.phx2.redhat.com [10.3.117.150])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0697A10018F9;
        Wed, 14 Aug 2019 16:34:15 +0000 (UTC)
Message-ID: <32c46e3de1a6641eb0d5940868f7d8b8a30181d3.camel@redhat.com>
Subject: Re: [PATCH v3 01/12] fpga: dfl: fme: support 512bit data width PR
From:   Scott Wood <swood@redhat.com>
To:     Wu Hao <hao.wu@intel.com>, Greg KH <gregkh@linuxfoundation.org>
Cc:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org, atull@kernel.org,
        Ananda Ravuri <ananda.ravuri@intel.com>,
        Xu Yilun <yilun.xu@intel.com>
Date:   Wed, 14 Aug 2019 11:34:15 -0500
In-Reply-To: <20190724142235.GE8463@hao-dev>
References: <1563857495-26692-1-git-send-email-hao.wu@intel.com>
         <1563857495-26692-2-git-send-email-hao.wu@intel.com>
         <20190724093532.GB29532@kroah.com> <20190724142235.GE8463@hao-dev>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Wed, 14 Aug 2019 16:34:17 +0000 (UTC)
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Wed, 2019-07-24 at 22:22 +0800, Wu Hao wrote:
> On Wed, Jul 24, 2019 at 11:35:32AM +0200, Greg KH wrote:
> > On Tue, Jul 23, 2019 at 12:51:24PM +0800, Wu Hao wrote:
> > >  
> > > @@ -67,8 +69,43 @@
> > >  #define PR_WAIT_TIMEOUT   8000000
> > >  #define PR_HOST_STATUS_IDLE	0
> > >  
> > > +#if defined(CONFIG_X86) && defined(CONFIG_AS_AVX512)
> > > +
> > > +#include <linux/cpufeature.h>
> > > +#include <asm/fpu/api.h>
> > > +
> > > +static inline int is_cpu_avx512_enabled(void)
> > > +{
> > > +	return cpu_feature_enabled(X86_FEATURE_AVX512F);
> > > +}
> > 
> > That's a very arch specific function, why would a driver ever care about
> > this?
> 
> Yes, this is only applied to a specific FPGA solution, which FPGA
> has been integrated with XEON. Hardware indicates this using register
> to software. As it's cpu integrated solution, so CPU always has this
> AVX512 capability. The only check we do, is make sure this is not
> manually disabled by kernel.
> 
> With this hardware, software could use AVX512 to accelerate the FPGA
> partial reconfiguration as mentioned in the patch commit message.
> It brings performance benifits to people who uses it. This is only one
> optimization (512 vs 32bit data write to hw) for a specific hardware.

I thought earlier you said that 512 bit accesses were required for this
particular integrated-only version of the device, and not just an
optimization?

> > > +#else
> > > +static inline int is_cpu_avx512_enabled(void)
> > > +{
> > > +	return 0;
> > > +}
> > > +
> > > +static inline void copy512(const void *src, void __iomem *dst)
> > > +{
> > > +	WARN_ON_ONCE(1);
> > 
> > Are you trying to get reports from syzbot?  :)
> 
> Oh.. no.. I will remove it. :)
> 
> Thank you very much!

What's wrong with this?  The driver should never call copy512() if
is_cpu_avx512_enabled() returns 0, and if syzbot can somehow make the driver
do so, then yes we do want a report.

-Scott


