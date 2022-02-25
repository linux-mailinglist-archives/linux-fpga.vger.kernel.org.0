Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02EF04C49FC
	for <lists+linux-fpga@lfdr.de>; Fri, 25 Feb 2022 17:03:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242434AbiBYQBY (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 25 Feb 2022 11:01:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237269AbiBYQBV (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 25 Feb 2022 11:01:21 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25A451F1244;
        Fri, 25 Feb 2022 08:00:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645804849; x=1677340849;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=K8VkR/kbOb0KBxltMFpm/So3glqC1wOwZKLM8ttnp2Q=;
  b=mfHUs5xE4+Fv4pz5ToCOywZ/faV6RtODyr4dR0Y2FlbJcYOxAUzw5xE5
   anh25m2VfiysZ4hK8/6KXl2nINzsVwWfJdwXd+Hdui5ibARUPW06aHaCh
   VN+uFzzF+FAfyfwnhJ5aBUPwtYbRwXD6gaqNsHVegSSWUMBnGwF75vQ/v
   sQqfQ1i5uhs+FBoGeyoudd93oCwJp/QJ64Ewr44QXukRABbXEiYpqWBLu
   OGEhKWzjAsllVJMWGDQgZe/Iq0qB5s5wP7O8rnHstjYNBgyZ82WLgd6y0
   iR3teCHu+AMudlUOScmv4lMOTWEwMQI+qx2VfN5sWaYp01VELfGgu3H5E
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10268"; a="315737207"
X-IronPort-AV: E=Sophos;i="5.90,136,1643702400"; 
   d="scan'208";a="315737207"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2022 08:00:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,136,1643702400"; 
   d="scan'208";a="533615385"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.68])
  by orsmga007.jf.intel.com with ESMTP; 25 Feb 2022 08:00:47 -0800
Date:   Fri, 25 Feb 2022 23:52:08 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Yusuf Khan <yusisamerican@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org,
        mdf@kernel.org, trix@redhat.com, hao.wu@intel.com
Subject: Re: [PATCH -next] pga: dfl: pci: Make sure DMA related error check
 is  not done twice
Message-ID: <20220225155208.GA1377611@yilunxu-OptiPlex-7050>
References: <20220222042700.385001-1-yusisamerican@gmail.com>
 <CAJoG2+-97KyWrxym2NXECRtjT9OxVQE_=DcNkUfOsPm_Ax90Aw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJoG2+-97KyWrxym2NXECRtjT9OxVQE_=DcNkUfOsPm_Ax90Aw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Mon, Feb 21, 2022 at 08:39:48PM -0800, Yusuf Khan wrote:
> Note: This bug was introduced here:
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/patch/?id=ada3caabaf6135150077c3f729bb06e8f3b5b8f6
> I saw this commit inside the linux-next branch, it is not present in
> the mainline branch.
> The linux-next branch was last updated 5 days ago, so I am unsure
> about the state of that commit.
> 
> On Mon, Feb 21, 2022 at 8:27 PM Yusuf Khan <yusisamerican@gmail.com> wrote:
> >
> > In the case that the DMA 64 bit bit mask error check does not fail,
> > the error check will be done twice, this patch fixed that.
> >
> > NOTE: This patch is only for use in the linux-next branch as the
> > commit that caused this bug happened there.
> >
> > Signed-off-by: Yusuf Khan <yusisamerican@gmail.com>
> > ---
> >  drivers/fpga/dfl-pci.c | 9 +++++----
> >  1 file changed, 5 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/fpga/dfl-pci.c b/drivers/fpga/dfl-pci.c
> > index 717ac9715970..6222f18aed4b 100644
> > --- a/drivers/fpga/dfl-pci.c
> > +++ b/drivers/fpga/dfl-pci.c
> > @@ -356,11 +356,12 @@ int cci_pci_probe(struct pci_dev *pcidev, const struct pci_device_id *pcidevid)
> >         pci_set_master(pcidev);
> >
> >         ret = dma_set_mask_and_coherent(&pcidev->dev, DMA_BIT_MASK(64));
> > -       if (ret)
> > -               ret = dma_set_mask_and_coherent(&pcidev->dev, DMA_BIT_MASK(32));
> >         if (ret) {
> > -               dev_err(&pcidev->dev, "No suitable DMA support available.\n");
> > -               goto disable_error_report_exit;
> > +               ret = dma_set_mask_and_coherent(&pcidev->dev, DMA_BIT_MASK(32));
> > +               if (ret) {
> > +                       dev_err(&pcidev->dev, "No suitable DMA support available.\n");
> > +                       goto disable_error_report_exit;
> > +               }

Looks good to me.

Acked-by: Xu Yilun <yilun.xu@intel.com>

> >         }
> >
> >         ret = cci_init_drvdata(pcidev);
> > --
> > 2.25.1
> >
