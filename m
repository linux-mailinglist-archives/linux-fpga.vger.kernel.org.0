Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DEC34C8164
	for <lists+linux-fpga@lfdr.de>; Tue,  1 Mar 2022 04:01:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231279AbiCADAs (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 28 Feb 2022 22:00:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiCADAr (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 28 Feb 2022 22:00:47 -0500
Received: from mail-vk1-xa30.google.com (mail-vk1-xa30.google.com [IPv6:2607:f8b0:4864:20::a30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FFFE64F6;
        Mon, 28 Feb 2022 19:00:08 -0800 (PST)
Received: by mail-vk1-xa30.google.com with SMTP id m195so3632353vka.5;
        Mon, 28 Feb 2022 19:00:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PyFDsjmMKCqCZKwZNSrr3EREFHubLTbckVDLvVietaU=;
        b=X6mnErHq65YWhzNZHRlesTamjFZcKlaJLfGucbQoHbCZgZP4nCT0epAPgEh+PSLRN1
         +jneDkLI4XuVkBng+8fJ6Q4z+Tm6HLAy1PKzmT/faxWbM2MrR+xEyN7OxrK18NdODol+
         XliNc9pSvAAuxPEIpNjwfNAqjxKaY6lJ4gF+uOzS+CfPip9oRbZocx9EApN/BKajjtsl
         lPe57SpnRVx0+vccfjCIPanLjz802Jqs63UG0gHwp9TDAkVmOTqZm5lUxXwjEhp2M99Z
         p5BYC6BaAtEjnCGgucM7ThYstqQmCxiSGLxLi7cSuknSDHlrfNWnjzN6MnrSEqcv4jRC
         H1QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PyFDsjmMKCqCZKwZNSrr3EREFHubLTbckVDLvVietaU=;
        b=yj58VWY4sv+L54dqdCV43LvP73q+xE7/jIqydV6dlm2VDEZRUaI1fn+nJKcRBWWmky
         z34j9U5XL/KCVA1cVhVKVHUCiv71BmvuHORe6PrOptDUVTnaZnKOqHPeUgumCPx63Rz8
         rRRcZFGboE9i3U6cPnGzkbV3QJ1yJ2znGyigRzrP/HJMJ5kf3QfK3z9xx3GniHEuliZC
         1ziqlttru6I8kluuL1gBBDkyc11ieGvdcKNmVDPiHamLqEhuEB4wN9PTMNyMuAfFu8m6
         wsIrhIt6HqYCNWM7wmbWegC0RxcMKbnAbV7cklx5/r905rjj3uXfZs57ozI8tWfO9AYm
         1AQA==
X-Gm-Message-State: AOAM533/BJRLR+a5UvF3Ttz4eyZPOhkaBc/gzJ9ayldH9LWKBRMgHXG5
        r1DcKWEESQy+9oWp9AYjaPfQ16UZE3W8Mk/tDAU=
X-Google-Smtp-Source: ABdhPJxL0JFdoBNZaFdNeJfNHoiRzjzyhhKoX1uvp6TBOA2ZxZFxbx6TVaZ20mHkYB4n4q0Y5lcnnHyUo/X8csEZAl4=
X-Received: by 2002:a05:6122:d11:b0:331:2101:1238 with SMTP id
 az17-20020a0561220d1100b0033121011238mr10015708vkb.22.1646103607142; Mon, 28
 Feb 2022 19:00:07 -0800 (PST)
MIME-Version: 1.0
References: <20220222042700.385001-1-yusisamerican@gmail.com>
 <CAJoG2+-97KyWrxym2NXECRtjT9OxVQE_=DcNkUfOsPm_Ax90Aw@mail.gmail.com>
 <20220225155208.GA1377611@yilunxu-OptiPlex-7050> <DM6PR11MB3819C9631EAED0AFE7E8D99B85019@DM6PR11MB3819.namprd11.prod.outlook.com>
 <CAJoG2+--e6BqpwBYO0w4d_aUwmCmJVch=mvfq7idW__PRxsv6w@mail.gmail.com> <DM6PR11MB3819F561A8EEB59D9EA1482685029@DM6PR11MB3819.namprd11.prod.outlook.com>
In-Reply-To: <DM6PR11MB3819F561A8EEB59D9EA1482685029@DM6PR11MB3819.namprd11.prod.outlook.com>
From:   Yusuf Khan <yusisamerican@gmail.com>
Date:   Mon, 28 Feb 2022 18:59:56 -0800
Message-ID: <CAJoG2+8j5P11h8HQPbR7W8dQ2WnTF41dtVoztOuxhxqqk5OwDQ@mail.gmail.com>
Subject: Re: [PATCH -next] pga: dfl: pci: Make sure DMA related error check is
 not done twice
To:     "Wu, Hao" <hao.wu@intel.com>
Cc:     "Xu, Yilun" <yilun.xu@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "trix@redhat.com" <trix@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Done. Resent

On Mon, Feb 28, 2022 at 6:34 PM Wu, Hao <hao.wu@intel.com> wrote:
>
> > -----Original Message-----
> > From: Yusuf Khan <yusisamerican@gmail.com>
> > Sent: Tuesday, March 1, 2022 9:59 AM
> > To: Wu, Hao <hao.wu@intel.com>
> > Cc: Xu, Yilun <yilun.xu@intel.com>; linux-kernel@vger.kernel.org; linux-
> > fpga@vger.kernel.org; mdf@kernel.org; trix@redhat.com
> > Subject: Re: [PATCH -next] pga: dfl: pci: Make sure DMA related error check is
> > not done twice
> >
> > Will do, but I do not know exactly what to remove  from the commit message,
> > I understand what to do for the title
>
> > > > > > NOTE: This patch is only for use in the linux-next branch as the
> > > > > > commit that caused this bug happened there.
>
> Remove this NOTE
>
> Hao
>
> >
> > Yusuf
> >
> > On Mon, Feb 28, 2022 at 1:58 AM Wu, Hao <hao.wu@intel.com> wrote:
> > >
> > > > On Mon, Feb 21, 2022 at 08:39:48PM -0800, Yusuf Khan wrote:
> > > > > Note: This bug was introduced here:
> > > > > https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-
> > > > next.git/patch/?id=ada3caabaf6135150077c3f729bb06e8f3b5b8f6
> > > > > I saw this commit inside the linux-next branch, it is not present in
> > > > > the mainline branch.
> > > > > The linux-next branch was last updated 5 days ago, so I am unsure
> > > > > about the state of that commit.
> > > > >
> > > > > On Mon, Feb 21, 2022 at 8:27 PM Yusuf Khan <yusisamerican@gmail.com>
> > > > wrote:
> > > > > >
> > > > > > In the case that the DMA 64 bit bit mask error check does not fail,
> > > > > > the error check will be done twice, this patch fixed that.
> > > > > >
> > > > > > NOTE: This patch is only for use in the linux-next branch as the
> > > > > > commit that caused this bug happened there.
> > >
> > > Thanks for the patch.
> > > please remove this from the commit message, and fix the title
> > > s/pga/fpga/
> > >
> > > Thanks
> > > Hao
> > >
> > > > > >
> > > > > > Signed-off-by: Yusuf Khan <yusisamerican@gmail.com>
> > > > > > ---
> > > > > >  drivers/fpga/dfl-pci.c | 9 +++++----
> > > > > >  1 file changed, 5 insertions(+), 4 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/fpga/dfl-pci.c b/drivers/fpga/dfl-pci.c
> > > > > > index 717ac9715970..6222f18aed4b 100644
> > > > > > --- a/drivers/fpga/dfl-pci.c
> > > > > > +++ b/drivers/fpga/dfl-pci.c
> > > > > > @@ -356,11 +356,12 @@ int cci_pci_probe(struct pci_dev *pcidev, const
> > > > struct pci_device_id *pcidevid)
> > > > > >         pci_set_master(pcidev);
> > > > > >
> > > > > >         ret = dma_set_mask_and_coherent(&pcidev->dev,
> > DMA_BIT_MASK(64));
> > > > > > -       if (ret)
> > > > > > -               ret = dma_set_mask_and_coherent(&pcidev->dev,
> > > > DMA_BIT_MASK(32));
> > > > > >         if (ret) {
> > > > > > -               dev_err(&pcidev->dev, "No suitable DMA support available.\n");
> > > > > > -               goto disable_error_report_exit;
> > > > > > +               ret = dma_set_mask_and_coherent(&pcidev->dev,
> > > > DMA_BIT_MASK(32));
> > > > > > +               if (ret) {
> > > > > > +                       dev_err(&pcidev->dev, "No suitable DMA support
> > > > available.\n");
> > > > > > +                       goto disable_error_report_exit;
> > > > > > +               }
> > > >
> > > > Looks good to me.
> > > >
> > > > Acked-by: Xu Yilun <yilun.xu@intel.com>
> > > >
> > > > > >         }
> > > > > >
> > > > > >         ret = cci_init_drvdata(pcidev);
> > > > > > --
> > > > > > 2.25.1
> > > > > >
