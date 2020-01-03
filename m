Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0264512F3E2
	for <lists+linux-fpga@lfdr.de>; Fri,  3 Jan 2020 05:48:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726292AbgACEs2 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 2 Jan 2020 23:48:28 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34516 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726219AbgACEs1 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 2 Jan 2020 23:48:27 -0500
Received: by mail-pf1-f194.google.com with SMTP id i6so16167969pfc.1;
        Thu, 02 Jan 2020 20:48:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=9HyfmfkDLe8z+hNbOYw+jbaxOQYlFrX6m7GgODr/vBE=;
        b=f5nv1t2e+vbiBqqrpkV7Jmwuc8urYJtwe22m3vVbHu9BRj7zz+7xhGVAGe/5uO0avp
         fNt/ysb1TnzDD81dyZcYMgyOr9NqCoP5S/ReI40M8YfMFOZmDHANuVGY6PTLAJB64maC
         WSSfpaXtwNvS6bMV7F3jHq0xDSgEu/nD0jrRyQ+D+P7D7YKF9ekbHCrJOuQj5Votds3P
         GsG8wS+/oss9/blcmVsWHQUechKnHgiKu5GdKhn7EDgT7DzTUYOT8S9l1LWIUETlxg40
         6xJxf5M6vX2yUYFwqFpgPTKLVFPW8ZcuZO/1XEMGdmaMFwaqkSIVwvVyapi9rGlKnd72
         zLBw==
X-Gm-Message-State: APjAAAXNKb072cHmhFtvXOPt81euS8I+CcEkmnhgolSGzp52w1H4sGu/
        7hYUeKuQv1fVKicJTxY42ks=
X-Google-Smtp-Source: APXvYqxPw62mETu9DQLav2eTnGOZ32dRTKbQwX2zgF6JZ0Rd3iX/YB+h3YwL+tVLZuduzDjPGv8Yhw==
X-Received: by 2002:aa7:8b5a:: with SMTP id i26mr40387670pfd.214.1578026907131;
        Thu, 02 Jan 2020 20:48:27 -0800 (PST)
Received: from localhost ([2601:647:5b00:710:ffa7:88dc:9c39:76d9])
        by smtp.gmail.com with ESMTPSA id s185sm45410562pfc.35.2020.01.02.20.48.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2020 20:48:26 -0800 (PST)
Date:   Thu, 2 Jan 2020 20:48:25 -0800
From:   Moritz Fischer <mdf@kernel.org>
To:     Wu Hao <hao.wu@intel.com>
Cc:     Moritz Fischer <mdf@kernel.org>, yu kuai <yukuai3@huawei.com>,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawe.com, zhengbin13@huawei.com
Subject: Re: [PATCH] fpga: dfl: afu: remove set but not used variable 'afu'
Message-ID: <20200103044825.GA20838@epycbox.lan>
References: <20191226121533.6017-1-yukuai3@huawei.com>
 <20191227225809.GB1643@archbook>
 <20191230015312.GB6839@hao-dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191230015312.GB6839@hao-dev>
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Mon, Dec 30, 2019 at 09:53:12AM +0800, Wu Hao wrote:
> On Fri, Dec 27, 2019 at 02:58:09PM -0800, Moritz Fischer wrote:
> > On Thu, Dec 26, 2019 at 08:15:33PM +0800, yu kuai wrote:
> > > Fixes gcc '-Wunused-but-set-variable' warning:
> > > 
> > > drivers/fpga/dfl-afu-main.c: In function ‘afu_dev_destroy’:
> > > drivers/fpga/dfl-afu-main.c:816:18: warning: variable ‘afu’
> > > set but not used [-Wunused-but-set-variable]
> > > 
> > > It is never used, and so can be removed.
> > > 
> > > Signed-off-by: yu kuai <yukuai3@huawei.com>
> > > ---
> > >  drivers/fpga/dfl-afu-main.c | 2 --
> > >  1 file changed, 2 deletions(-)
> > > 
> > > diff --git a/drivers/fpga/dfl-afu-main.c b/drivers/fpga/dfl-afu-main.c
> > > index e4a34dc7947f..65437b6a6842 100644
> > > --- a/drivers/fpga/dfl-afu-main.c
> > > +++ b/drivers/fpga/dfl-afu-main.c
> > > @@ -813,10 +813,8 @@ static int afu_dev_init(struct platform_device *pdev)
> > >  static int afu_dev_destroy(struct platform_device *pdev)
> > >  {
> > >  	struct dfl_feature_platform_data *pdata = dev_get_platdata(&pdev->dev);
> > > -	struct dfl_afu *afu;
> > >  
> > >  	mutex_lock(&pdata->lock);
> > > -	afu = dfl_fpga_pdata_get_private(pdata);
> > >  	afu_mmio_region_destroy(pdata);
> > >  	afu_dma_region_destroy(pdata);
> > >  	dfl_fpga_pdata_set_private(pdata, NULL);
> > > -- 
> > > 2.17.2
> > > 
> > Acked-by: Moritz Fischer <mdf@kernel.org>
> > 
> > I'll get to the patches in the new year.
> 
> Thanks Kuai and Moritz. :)
> 
> Acked-by: Wu Hao <hao.wu@intel.com>
> 
> Hao
> > 
> > Thanks,
> > Moritz

Applied to for-next.

Thanks,
Moritz
