Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B30B181AF
	for <lists+linux-fpga@lfdr.de>; Wed,  8 May 2019 23:39:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbfEHVjx (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 8 May 2019 17:39:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49782 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726902AbfEHVjw (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 8 May 2019 17:39:52 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 978B43082E3F;
        Wed,  8 May 2019 21:39:52 +0000 (UTC)
Received: from ovpn-117-112.phx2.redhat.com (ovpn-117-112.phx2.redhat.com [10.3.117.112])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0FE8E608A6;
        Wed,  8 May 2019 21:39:51 +0000 (UTC)
Message-ID: <7d3a76c0c9115726402cfc52da92fd8e2cac426c.camel@redhat.com>
Subject: Re: [PATCH] fpga: dfl: afu: Pass the correct device to
 dma_mapping_error()
From:   Scott Wood <swood@redhat.com>
To:     Alan Tull <atull@kernel.org>,
        Moritz Fischer <moritz.fischer.private@gmail.com>
Cc:     Wu Hao <hao.wu@intel.com>, linux-fpga@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Wed, 08 May 2019 16:39:51 -0500
In-Reply-To: <CANk1AXTv2DFpRDAJ9UH9+LRo=wrmcbP02zbWbtTXku6iwPAhOw@mail.gmail.com>
References: <20190410215327.8024-1-swood@redhat.com>
         <20190411123314.GA19198@hao-dev>
         <CAJYdmeNX9F_EmTPBjQ1SXOOU=JBA1kBO6WEjBXTmJux4O-CR5A@mail.gmail.com>
         <CANk1AXTv2DFpRDAJ9UH9+LRo=wrmcbP02zbWbtTXku6iwPAhOw@mail.gmail.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Wed, 08 May 2019 21:39:52 +0000 (UTC)
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Mon, 2019-04-15 at 14:22 -0500, Alan Tull wrote:
> On Thu, Apr 11, 2019 at 11:36 AM Moritz Fischer
> <moritz.fischer.private@gmail.com> wrote:
> 
> Hi Scott,
> 
> Thanks!
> 
> > Hi Scott,
> > 
> > good catch!
> > 
> > On Thu, Apr 11, 2019 at 5:49 AM Wu Hao <hao.wu@intel.com> wrote:
> > > On Wed, Apr 10, 2019 at 04:53:27PM -0500, Scott Wood wrote:
> > > > dma_mapping_error() was being called on a different device struct
> > > > than
> > > > what was passed to map/unmap.  Besides rendering the error checking
> > > > ineffective, it caused a debug splat with CONFIG_DMA_API_DEBUG.
> > > > 
> > > > Signed-off-by: Scott Wood <swood@redhat.com>
> > > 
> > > Hi Scott,
> > > 
> > > Looks good to me. Thanks for catching this issue.
> > > 
> > > Acked-by: Wu Hao <hao.wu@intel.com>
> > > 
> > > Hao
> > > 
> > > > ---
> > > >  drivers/fpga/dfl-afu-dma-region.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > 
> > > > diff --git a/drivers/fpga/dfl-afu-dma-region.c b/drivers/fpga/dfl-
> > > > afu-dma-region.c
> > > > index e18a786fc943..cd68002ac097 100644
> > > > --- a/drivers/fpga/dfl-afu-dma-region.c
> > > > +++ b/drivers/fpga/dfl-afu-dma-region.c
> > > > @@ -399,7 +399,7 @@ int afu_dma_map_region(struct
> > > > dfl_feature_platform_data *pdata,
> > > >                                   region->pages[0], 0,
> > > >                                   region->length,
> > > >                                   DMA_BIDIRECTIONAL);
> > > > -     if (dma_mapping_error(&pdata->dev->dev, region->iova)) {
> > > > +     if (dma_mapping_error(dfl_fpga_pdata_to_parent(pdata), region-
> > > > >iova)) {
> > > >               dev_err(&pdata->dev->dev, "failed to map for dma\n");
> > > >               ret = -EFAULT;
> > > >               goto unpin_pages;
> > > > --
> > > > 1.8.3.1
> > 
> > Acked-by: Moritz Fischer <mdf@kernel.org>
> 
> Acked-by: Alan Tull <atull@kernel.org>

Whose tree would these patches be going through?

-Scott


