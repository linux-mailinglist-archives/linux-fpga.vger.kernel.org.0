Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92EF91DFB0B
	for <lists+linux-fpga@lfdr.de>; Sat, 23 May 2020 22:57:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387971AbgEWU5U (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 23 May 2020 16:57:20 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36142 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387947AbgEWU5U (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sat, 23 May 2020 16:57:20 -0400
Received: by mail-pg1-f194.google.com with SMTP id c75so6679734pga.3;
        Sat, 23 May 2020 13:57:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FAMTM8agctXMaG0UGWtbx5NqNA6ypNIUWGYaE6iGVQg=;
        b=EwCpZkYXN3p0gh2HYoBsaE8Jxcu6i+gO4ImQ8ZOh3TuxocYBGegsgIcPuNuK89rda9
         EVIA6EIkUj8szXgGZJfsNV2UM3aCIVs8qYosowVSqu7ooXd1LcHFmpnA9kB7lOmHzzLx
         fYHHb5vAAmNpuqDNRKKRjsXVg9r86ydxR+Zq10+LGpdqXt3+QoQfLtrac19h6TF6iYkP
         DeNWnBzf8S/3JKfWMTTdU+ImSF5etAPzZNgwq7YBEj2HLIWPJrJLVWWj2vq/RuGAsIVI
         HVo+mGA3z1ww5Wbmx1sWxlhkGXoP6VZWYQ2/VFjVgytxv9GMk8CdXcJxvI+hqJ0rn83t
         UaPA==
X-Gm-Message-State: AOAM533ZFtdEm2FWxjBQpgxlBwN5M53+sLjkAkSu7wrU8bia7nn70/fD
        1FD5whQ+s5Ys3pByrPsvkk8=
X-Google-Smtp-Source: ABdhPJxDFjY6rayx1BYmwpGoC4kzKGZrUW2SzFQtq7crgGpz8AJwuENuBQgG7Y3qPb0N0ZZO6/uNdg==
X-Received: by 2002:a63:658:: with SMTP id 85mr19303222pgg.181.1590267439241;
        Sat, 23 May 2020 13:57:19 -0700 (PDT)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id s123sm9757424pfs.170.2020.05.23.13.57.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2020 13:57:18 -0700 (PDT)
Date:   Sat, 23 May 2020 13:57:17 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, Xu Yilun <yilun.xu@intel.com>,
        Wu Hao <hao.wu@intel.com>, Moritz Fischer <mdf@kernel.org>,
        linux-fpga@vger.kernel.org
Subject: Re: [PATCH v2] fpga: dfl: afu: convert get_user_pages() -->
 pin_user_pages()
Message-ID: <20200523205717.GA443638@epycbox.lan>
References: <20200519201449.3136033-1-jhubbard@nvidia.com>
 <64aa1494-7570-5319-b096-ea354ff20431@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64aa1494-7570-5319-b096-ea354ff20431@nvidia.com>
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Fri, May 22, 2020 at 06:52:34PM -0700, John Hubbard wrote:
> On 2020-05-19 13:14, John Hubbard wrote:
> > This code was using get_user_pages_fast(), in a "Case 2" scenario
> > (DMA/RDMA), using the categorization from [1]. That means that it's
> > time to convert the get_user_pages_fast() + put_page() calls to
> > pin_user_pages_fast() + unpin_user_pages() calls.
> > 
> > There is some helpful background in [2]: basically, this is a small
> > part of fixing a long-standing disconnect between pinning pages, and
> > file systems' use of those pages.
> > 
> > [1] Documentation/core-api/pin_user_pages.rst
> > 
> > [2] "Explicit pinning of user-space pages":
> >      https://lwn.net/Articles/807108/
> > 
> > Cc: Xu Yilun <yilun.xu@intel.com>
> > Cc: Wu Hao <hao.wu@intel.com>
> > Cc: Moritz Fischer <mdf@kernel.org>
> > Cc: linux-fpga@vger.kernel.org
> > Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> 
> 
> Hi Moritz and FPGA developers,
> 
> Is this OK? And if so, is it going into your git tree? Or should I
> send it up through a different tree? (I'm new to the FPGA development
> model).

I can take it, sorry for sluggish response.

Cheers,
Moritz

> 
> 
> thanks,
> -- 
> John Hubbard
> NVIDIA
> 
> 
> 
> > ---
> > 
> > Hi,
> > 
> > Changes since v1:
> > 
> > Changed the label from "put_pages", to "unpin_pages".
> > 
> > thanks,
> > John Hubbard
> > NVIDIA
> >   drivers/fpga/dfl-afu-dma-region.c | 19 +++++--------------
> >   1 file changed, 5 insertions(+), 14 deletions(-)
> > 
> > diff --git a/drivers/fpga/dfl-afu-dma-region.c b/drivers/fpga/dfl-afu-dma-region.c
> > index 62f924489db5..a31dd3a7e581 100644
> > --- a/drivers/fpga/dfl-afu-dma-region.c
> > +++ b/drivers/fpga/dfl-afu-dma-region.c
> > @@ -16,15 +16,6 @@
> >   #include "dfl-afu.h"
> > -static void put_all_pages(struct page **pages, int npages)
> > -{
> > -	int i;
> > -
> > -	for (i = 0; i < npages; i++)
> > -		if (pages[i])
> > -			put_page(pages[i]);
> > -}
> > -
> >   void afu_dma_region_init(struct dfl_feature_platform_data *pdata)
> >   {
> >   	struct dfl_afu *afu = dfl_fpga_pdata_get_private(pdata);
> > @@ -57,11 +48,11 @@ static int afu_dma_pin_pages(struct dfl_feature_platform_data *pdata,
> >   		goto unlock_vm;
> >   	}
> > -	pinned = get_user_pages_fast(region->user_addr, npages, FOLL_WRITE,
> > +	pinned = pin_user_pages_fast(region->user_addr, npages, FOLL_WRITE,
> >   				     region->pages);
> >   	if (pinned < 0) {
> >   		ret = pinned;
> > -		goto put_pages;
> > +		goto unpin_pages;
> >   	} else if (pinned != npages) {
> >   		ret = -EFAULT;
> >   		goto free_pages;
> > @@ -71,8 +62,8 @@ static int afu_dma_pin_pages(struct dfl_feature_platform_data *pdata,
> >   	return 0;
> > -put_pages:
> > -	put_all_pages(region->pages, pinned);
> > +unpin_pages:
> > +	unpin_user_pages(region->pages, pinned);
> >   free_pages:
> >   	kfree(region->pages);
> >   unlock_vm:
> > @@ -94,7 +85,7 @@ static void afu_dma_unpin_pages(struct dfl_feature_platform_data *pdata,
> >   	long npages = region->length >> PAGE_SHIFT;
> >   	struct device *dev = &pdata->dev->dev;
> > -	put_all_pages(region->pages, npages);
> > +	unpin_user_pages(region->pages, npages);
> >   	kfree(region->pages);
> >   	account_locked_vm(current->mm, npages, false);
> > 
> 
