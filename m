Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32DBB4C80A4
	for <lists+linux-fpga@lfdr.de>; Tue,  1 Mar 2022 03:01:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232165AbiCACA2 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 28 Feb 2022 21:00:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232171AbiCACAX (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 28 Feb 2022 21:00:23 -0500
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com [IPv6:2607:f8b0:4864:20::933])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34C6B38D98;
        Mon, 28 Feb 2022 17:59:29 -0800 (PST)
Received: by mail-ua1-x933.google.com with SMTP id a28so1782950uaf.7;
        Mon, 28 Feb 2022 17:59:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f9mcavcZ3DY94pj3isyE2zgAKVT28x47K4KRhuEpv6Q=;
        b=ULr67TFox3RLB7SGJSFxa+NZLUv1bHUeSyhisqV+HNwBrTddKytuBp2MNcLed/VQpe
         l9zbE5RTm/Imu7PBpGjLc9Gz+n7hgSm9ZHy6Nw+SUOT5PZUcxF4WzMBGMg9GTDEGQCm/
         si81w2ngBWAgaZufKKYgLdFqVRUaOw3AVWfxs6T7xIG/7YXRuqHet8+R+J9UgFSzE7/B
         U2LfKUNMafXhYUiHtQpwlVwJ3rppiXsB8dwawdQxjiXi2Gl3tDHz0J7x0eXnukUbuX4C
         qYq4V8UzXJ+KgSKKE5grqQJwwn64qzCD4LyaRijO2oHbhH8kK+EmMcUDxTP/Xc/S8BKE
         TZsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f9mcavcZ3DY94pj3isyE2zgAKVT28x47K4KRhuEpv6Q=;
        b=4y2w7r6K3PEOJMDMoj0M8KflQFCMMRJ2QTMRzYxYOc4d+8qQ6BYUHScyAk3n26hrbQ
         juXqt3/dr84qQAtymmXKFCu4xkeSfM90momhtxbPcA1E3LxQThfbx/Kol4isdfs9nN/s
         hv6QAnf9uqxmk1EbRrIjvH48et7o/CkYTZ2GjYt7+lPfeFrI95yoiY9D+kmv2MjhvHo7
         F3VfYdujHpyFJmcyK7MDS1Q2Avi4MSVk3bVXkBRir2t1+VR9FyszqbLzuwksIC1gP7AY
         Aqa/G8kSktM93Ffs488iJxtOEfOJRPtb4kYj1sL5OJGpG6ApmM4U+3o/VcX8LPti3+nX
         fm4w==
X-Gm-Message-State: AOAM5311AW5z7trhTRdJE3NaTneJoyhsBsNOE6hyQzepajCYB3j6yiPx
        x5TkWQI8vVLoDISupRc99iArQtgcPADw01SfYS8=
X-Google-Smtp-Source: ABdhPJxoiWGfFp+U7mgMRQ9mB+8YY2DQDRlM2bRtZnZScmYZqfYoRf/PUDbxoZRuX8/BkJNU9+sPwbeI2ACWEikb8kc=
X-Received: by 2002:ab0:5b87:0:b0:33d:b78c:56ca with SMTP id
 y7-20020ab05b87000000b0033db78c56camr9261800uae.117.1646099968324; Mon, 28
 Feb 2022 17:59:28 -0800 (PST)
MIME-Version: 1.0
References: <20220222042700.385001-1-yusisamerican@gmail.com>
 <CAJoG2+-97KyWrxym2NXECRtjT9OxVQE_=DcNkUfOsPm_Ax90Aw@mail.gmail.com>
 <20220225155208.GA1377611@yilunxu-OptiPlex-7050> <DM6PR11MB3819C9631EAED0AFE7E8D99B85019@DM6PR11MB3819.namprd11.prod.outlook.com>
In-Reply-To: <DM6PR11MB3819C9631EAED0AFE7E8D99B85019@DM6PR11MB3819.namprd11.prod.outlook.com>
From:   Yusuf Khan <yusisamerican@gmail.com>
Date:   Mon, 28 Feb 2022 17:59:17 -0800
Message-ID: <CAJoG2+--e6BqpwBYO0w4d_aUwmCmJVch=mvfq7idW__PRxsv6w@mail.gmail.com>
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

Will do, but I do not know exactly what to remove  from the commit message,
I understand what to do for the title

Yusuf

On Mon, Feb 28, 2022 at 1:58 AM Wu, Hao <hao.wu@intel.com> wrote:
>
> > On Mon, Feb 21, 2022 at 08:39:48PM -0800, Yusuf Khan wrote:
> > > Note: This bug was introduced here:
> > > https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-
> > next.git/patch/?id=ada3caabaf6135150077c3f729bb06e8f3b5b8f6
> > > I saw this commit inside the linux-next branch, it is not present in
> > > the mainline branch.
> > > The linux-next branch was last updated 5 days ago, so I am unsure
> > > about the state of that commit.
> > >
> > > On Mon, Feb 21, 2022 at 8:27 PM Yusuf Khan <yusisamerican@gmail.com>
> > wrote:
> > > >
> > > > In the case that the DMA 64 bit bit mask error check does not fail,
> > > > the error check will be done twice, this patch fixed that.
> > > >
> > > > NOTE: This patch is only for use in the linux-next branch as the
> > > > commit that caused this bug happened there.
>
> Thanks for the patch.
> please remove this from the commit message, and fix the title
> s/pga/fpga/
>
> Thanks
> Hao
>
> > > >
> > > > Signed-off-by: Yusuf Khan <yusisamerican@gmail.com>
> > > > ---
> > > >  drivers/fpga/dfl-pci.c | 9 +++++----
> > > >  1 file changed, 5 insertions(+), 4 deletions(-)
> > > >
> > > > diff --git a/drivers/fpga/dfl-pci.c b/drivers/fpga/dfl-pci.c
> > > > index 717ac9715970..6222f18aed4b 100644
> > > > --- a/drivers/fpga/dfl-pci.c
> > > > +++ b/drivers/fpga/dfl-pci.c
> > > > @@ -356,11 +356,12 @@ int cci_pci_probe(struct pci_dev *pcidev, const
> > struct pci_device_id *pcidevid)
> > > >         pci_set_master(pcidev);
> > > >
> > > >         ret = dma_set_mask_and_coherent(&pcidev->dev, DMA_BIT_MASK(64));
> > > > -       if (ret)
> > > > -               ret = dma_set_mask_and_coherent(&pcidev->dev,
> > DMA_BIT_MASK(32));
> > > >         if (ret) {
> > > > -               dev_err(&pcidev->dev, "No suitable DMA support available.\n");
> > > > -               goto disable_error_report_exit;
> > > > +               ret = dma_set_mask_and_coherent(&pcidev->dev,
> > DMA_BIT_MASK(32));
> > > > +               if (ret) {
> > > > +                       dev_err(&pcidev->dev, "No suitable DMA support
> > available.\n");
> > > > +                       goto disable_error_report_exit;
> > > > +               }
> >
> > Looks good to me.
> >
> > Acked-by: Xu Yilun <yilun.xu@intel.com>
> >
> > > >         }
> > > >
> > > >         ret = cci_init_drvdata(pcidev);
> > > > --
> > > > 2.25.1
> > > >
