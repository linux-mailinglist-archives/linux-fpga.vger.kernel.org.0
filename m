Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E574C1D63F3
	for <lists+linux-fpga@lfdr.de>; Sat, 16 May 2020 22:22:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbgEPUWn (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 16 May 2020 16:22:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726528AbgEPUWn (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Sat, 16 May 2020 16:22:43 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEDB2C061A0C;
        Sat, 16 May 2020 13:22:42 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id w10so5816603ljo.0;
        Sat, 16 May 2020 13:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6KqPhCBNJhZ1XRzaZS7zC4GjdNL+qb+xQbQdcmNhs0M=;
        b=EiI9YTaVS3MkuyxxITMvw6mWfcC6HBmzsyG3q8W7vachz5iKebbbH97iymAqUx5a/4
         3ZmcKmqCWzxiw0fMAY3U2XX/F1t/smtxadCVakkR3geX9ln1MTmrovISOAZvOQ9SvOgq
         aRl2e2+t60xBcQRWEyeFyDR/HvA1FsXjMQlvWWnRI9slpksEonINcTxB1lMi5C2h/kty
         +lXWvPyci8ZScnWB2Yo8I+WN95MZbbT/qHmutFLRtLW66ovPSIvvskI3+l63VDebxOaG
         +ZKEqU6tWXooDENA+AMiFpbB08Pt9q2UQB5q5vu3xgvViBbzIu0fpDWaS3D8GGwQLRcb
         Uppw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6KqPhCBNJhZ1XRzaZS7zC4GjdNL+qb+xQbQdcmNhs0M=;
        b=IneRWqxjq+6gPwQYwBR0sJfRVCtWKTPpyhz7GaNgoD78unHiMGa9Z7R+1ev4UtDg+u
         tCDBEp5Lzk1ahVKoIwiB8/RdzJuW+dBwsGvFyR2cmXyt7HTOxaVFOwQLXbZVAAdM9a1e
         xCXiSPSbbobUmkWGte+b3EHBswxogIvQOmCKGhTSZQ3TNHdew6fM894IERadTc+ynL9M
         3kgGh/8IooLZjTMv3iccdwuShDBlclaBR2gbWAiRdNhFqWDoTG97/0QCJXRom91mkiln
         PCpi8NIOPhIj2JL9IlUQcHlvQt9WGPT9tE3JB6X0xCo2qmZwS75ZMDIwgioLkv0a8wm7
         UJ0A==
X-Gm-Message-State: AOAM530sMvowb0+a9giRK+QLgvwoFqUg1HiBga1WR0jORW/1VNU0GjCb
        ahxcG7Y3WSXo4MshxARJVlEVaQBDqw1hlA+is0g=
X-Google-Smtp-Source: ABdhPJwbQnCHHyI6TTUkG6NNih+ZVsupRNirwqpWKtXQ6347NTxaWGCCWSGQ4HFwhZtrOPwr8p2iO8hpPgK2dPTRwf4=
X-Received: by 2002:a05:651c:50e:: with SMTP id o14mr6092901ljp.52.1589660561294;
 Sat, 16 May 2020 13:22:41 -0700 (PDT)
MIME-Version: 1.0
References: <1589397725-29697-1-git-send-email-jrdr.linux@gmail.com>
 <20200514022935.GE29933@yilunxu-OptiPlex-7050> <DM6PR11MB38193B495FB1DB4697F0094F85BC0@DM6PR11MB3819.namprd11.prod.outlook.com>
In-Reply-To: <DM6PR11MB38193B495FB1DB4697F0094F85BC0@DM6PR11MB3819.namprd11.prod.outlook.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Sun, 17 May 2020 01:52:29 +0530
Message-ID: <CAFqt6zYA1EotyQSeBa19mC_Az8MbPUyfYZvjYWb01bm927FH4A@mail.gmail.com>
Subject: Re: [PATCH] fpga: dfl: afu: Corrected error handling levels
To:     "Wu, Hao" <hao.wu@intel.com>
Cc:     "mdf@kernel.org" <mdf@kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Xu, Yilun" <yilun.xu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Thu, May 14, 2020 at 11:36 AM Wu, Hao <hao.wu@intel.com> wrote:
>
> > -----Original Message-----
> > From: Xu, Yilun <yilun.xu@intel.com>
> > Sent: Thursday, May 14, 2020 10:30 AM
> > To: Souptick Joarder <jrdr.linux@gmail.com>
> > Cc: Wu, Hao <hao.wu@intel.com>; mdf@kernel.org; linux-
> > fpga@vger.kernel.org; linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH] fpga: dfl: afu: Corrected error handling levels
> >
> > The patch looks good to me.
> >
> > Maybe we could add the Fixes tag:
> >   Fixes: fa8dda1edef9 (fpga: dfl: afu: add
> > DFL_FPGA_PORT_DMA_MAP/UNMAP ioctls support)
>
> Thanks for catching this problem.
>
> With this line,
> Acked-by: Wu Hao <hao.wu@intel.com>

Thanks. Will post v2.

>
> Thanks!
> Hao
>
> >
> > Thanks,
> > Yilun
> >
> > On Thu, May 14, 2020 at 12:52:05AM +0530, Souptick Joarder wrote:
> > > Corrected error handling goto sequnece. Level put_pages should
> > > be called when pinned pages >= 0 && pinned != npages. Level
> > > free_pages should be called when pinned pages < 0.
> > >
> > > Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> > > ---
> > >  drivers/fpga/dfl-afu-dma-region.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/fpga/dfl-afu-dma-region.c b/drivers/fpga/dfl-afu-dma-
> > region.c
> > > index 62f9244..5942343 100644
> > > --- a/drivers/fpga/dfl-afu-dma-region.c
> > > +++ b/drivers/fpga/dfl-afu-dma-region.c
> > > @@ -61,10 +61,10 @@ static int afu_dma_pin_pages(struct
> > dfl_feature_platform_data *pdata,
> > >                                  region->pages);
> > >     if (pinned < 0) {
> > >             ret = pinned;
> > > -           goto put_pages;
> > > +           goto free_pages;
> > >     } else if (pinned != npages) {
> > >             ret = -EFAULT;
> > > -           goto free_pages;
> > > +           goto put_pages;
> > >     }
> > >
> > >     dev_dbg(dev, "%d pages pinned\n", pinned);
> > > --
> > > 1.9.1
