Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 440966DC124
	for <lists+linux-fpga@lfdr.de>; Sun,  9 Apr 2023 21:02:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbjDITAd (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 9 Apr 2023 15:00:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjDITAc (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 9 Apr 2023 15:00:32 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08F9F30F7;
        Sun,  9 Apr 2023 12:00:28 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-50489d2f5e0so765494a12.3;
        Sun, 09 Apr 2023 12:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681066826;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CbkAOGdtvtnwqGRrwMSF8jAQAGnOlEwbF+SCF6w1W1E=;
        b=h0DPVci2IbEjLzd9n+q0OGY+ug7P9W3pfyNWIzcYxUpqSA74e3eaisnpc6R69c5Nx2
         Wd/VKB+HLqawuHBw3dPMQqxDFdmiDl2JVqW/XpEkQ/l4Z746iDX6CNchhUsoDq3hQGCv
         5fQCTgme+r4xPKQV5HJpQDdDxOgiVFI3XEOc+f11gPti/OGgyaUMyS1GheUpxg7sPn2x
         MpQXM9RCqouUKZub6YZzx61WP1bUnCWw33y+TMjY+SVJA0NhZA7xLIVbWI3r6Xrf4x8t
         3U8RMyW8P/OWG+sf/78fCBza37szYkdTrKssCEYO2eZkC18PZ4V2UT814cH7Q0yKW/r5
         9r8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681066826;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CbkAOGdtvtnwqGRrwMSF8jAQAGnOlEwbF+SCF6w1W1E=;
        b=XYktXB1O8jIE6fQw+2Onk/cxrl/fnv1zmUoWFp3keFwFm7ImJt5ugxXlVwXmTvB7vs
         3VhnT9zyUHGAvu/5JDG3I5HLiVt2WXrC61UlSoNfOkfPW4GTWgSt5VZOrUHRUVbdoe7X
         Q5vhDJhQ4e4sbuva3gd98vSaglg5VBbEwE0i4/MnZlBbAt39EIOKiSBzJTLApfltLqc5
         totxAMLQUWCawFYJ/tcdQA9iTlye/31jCaG1uRGjXPgP3CVmt9c9h63v7XhBf0CkfiTn
         8dS3mVaHIBj42i3XdCuUPm7jNA2Skvf1oQeW6BGohRWubCHD0n8yPir00pOKp+4BbwIj
         pe2w==
X-Gm-Message-State: AAQBX9fBz4886mXzvZXPGDRzCsLpWRwD1sn0aJYoImdfAqlNIQ65jtq+
        8gihr9wSov9aY1LhI4UxKEg=
X-Google-Smtp-Source: AKy350aAx0/hQBUatRc+yWR2Mi3zmKau7uRRgMxSnfchgogX6BIOiPEkkkCYydEhlypePMGTW3yNjA==
X-Received: by 2002:a05:6402:12c9:b0:4a0:e305:a0de with SMTP id k9-20020a05640212c900b004a0e305a0demr9248329edx.19.1681066826116;
        Sun, 09 Apr 2023 12:00:26 -0700 (PDT)
Received: from eldamar.lan (c-82-192-242-114.customer.ggaweb.ch. [82.192.242.114])
        by smtp.gmail.com with ESMTPSA id l18-20020a50c112000000b004fc01b0aa55sm4148969edf.4.2023.04.09.12.00.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Apr 2023 12:00:25 -0700 (PDT)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
        id E550BBE2DE0; Sun,  9 Apr 2023 21:00:24 +0200 (CEST)
Date:   Sun, 9 Apr 2023 21:00:24 +0200
From:   Salvatore Bonaccorso <carnil@debian.org>
To:     Xu Yilun <yilun.xu@intel.com>, Sangsup Lee <k1rh4.lee@gmail.com>
Cc:     k1rh4.lee@gmail.com, Wu Hao <hao.wu@intel.com>,
        Tom Rix <trix@redhat.com>, Moritz Fischer <mdf@kernel.org>,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fpga: dfl-afu-region: Add overflow checks for region
 size and offset
Message-ID: <ZDMLSOoMt5Ims6xT@eldamar.lan>
References: <20230206054326.89323-1-k1rh4.lee@gmail.com>
 <Y+X+kZResf0a/aES@yilunxu-OptiPlex-7050>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+X+kZResf0a/aES@yilunxu-OptiPlex-7050>
X-Spam-Status: No, score=0.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi,

On Fri, Feb 10, 2023 at 04:21:37PM +0800, Xu Yilun wrote:
> On 2023-02-05 at 21:43:26 -0800, k1rh4.lee@gmail.com wrote:
> > From: Sangsup Lee <k1rh4.lee@gmail.com>
> > 
> > The size + offset is able to be integer overflow value and it lead to mis-allocate region.
> 
> But I didn't see the memory allocation.
> 
> > 
> > Signed-off-by: Sangsup Lee <k1rh4.lee@gmail.com>
> > ---
> >  drivers/fpga/dfl-afu-region.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/fpga/dfl-afu-region.c b/drivers/fpga/dfl-afu-region.c
> > index 2e7b41629406..82b530111601 100644
> > --- a/drivers/fpga/dfl-afu-region.c
> > +++ b/drivers/fpga/dfl-afu-region.c
> > @@ -151,12 +151,17 @@ int afu_mmio_region_get_by_offset(struct dfl_feature_platform_data *pdata,
> >  	struct dfl_afu_mmio_region *region;
> >  	struct dfl_afu *afu;
> >  	int ret = 0;
> > +	u64 region_size = 0;
> 
> Reverse Xmax tree please.
> 
> >  
> >  	mutex_lock(&pdata->lock);
> > +	if (check_add_overflow(offset, size, &region_size)) {
> 
> I'm not sure if the check is necessary.
> 
> The offset comes from: offset = vma->vm_pgoff << PAGE_SHIFT
> The size comes from: size = vma->vm_end - vma->vm_start
> Is it possible the upper mm layer passes invalid vma?
> 
> Thanks,
> Yilun

Did you saw the comments on your patch by Yilun? Did it felt trough
the cracks?

Regards,
Salvatore
