Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36F7B12F3E4
	for <lists+linux-fpga@lfdr.de>; Fri,  3 Jan 2020 05:49:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726219AbgACEt0 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 2 Jan 2020 23:49:26 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:54238 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbgACEt0 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 2 Jan 2020 23:49:26 -0500
Received: by mail-pj1-f68.google.com with SMTP id n96so4125760pjc.3;
        Thu, 02 Jan 2020 20:49:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=c7vB/owjAGocjJkQyceIEpdT371hvlmQPecB01G/CHI=;
        b=sME+BpFtQRuc4tKfCnxfCV7aOcQLSy+O/5xanIJJPV5iof9iizE18sTL5CkzNhZoxC
         w+0HkyVctxbJONtbb9hoXHtwqid6C6Yf7sTWnRV24tvMg4q6CwIl9lOlMlnZBS60FT/a
         QM0VX/HXozO4gUN70cqzkM0ciYw/rwSEesegANe80mZkjAneyrRf+0AL30PQ5yIoVvYb
         tbIHfS9gQCkpKLBtWfDrq1W7TUwn7MRZQySmzorU+QPwRn9hCbW3Xr+RK95RwJ5Clzjl
         OwklaAN9ieWVp6X3/qI7MBvU/i/02MHf5yC49trq2RUkMX64DhNRZ1VTNig+NxOmiUBu
         vsow==
X-Gm-Message-State: APjAAAU0Eh7GggBn9Xrk5YV1eFgeioDtxISFT9l49RZv6bySqZTv8YeI
        q4BF+NwEdId9lY3U32nXjoc=
X-Google-Smtp-Source: APXvYqzRsftPC0MUnG1KprOXPr0Rm0qBCGlylIkz3RsUISL+i1SrgO62IeFC+LTOWbQ+GMdkNnK0cA==
X-Received: by 2002:a17:90a:8584:: with SMTP id m4mr24523979pjn.123.1578026965718;
        Thu, 02 Jan 2020 20:49:25 -0800 (PST)
Received: from localhost ([2601:647:5b00:710:ffa7:88dc:9c39:76d9])
        by smtp.gmail.com with ESMTPSA id z26sm34911250pfa.90.2020.01.02.20.49.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2020 20:49:24 -0800 (PST)
Date:   Thu, 2 Jan 2020 20:49:24 -0800
From:   Moritz Fischer <mdf@kernel.org>
To:     Wu Hao <hao.wu@intel.com>
Cc:     Moritz Fischer <mdf@kernel.org>, yu kuai <yukuai3@huawei.com>,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawe.com, zhengbin13@huawei.com
Subject: Re: [PATCH] fpga: dfl: fme: remove set but not used variable 'fme'
Message-ID: <20200103044924.GB20838@epycbox.lan>
References: <20191226121638.10507-1-yukuai3@huawei.com>
 <20191227225726.GA1643@archbook>
 <20191230015140.GA6839@hao-dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191230015140.GA6839@hao-dev>
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Mon, Dec 30, 2019 at 09:51:40AM +0800, Wu Hao wrote:
> On Fri, Dec 27, 2019 at 02:57:26PM -0800, Moritz Fischer wrote:
> > On Thu, Dec 26, 2019 at 08:16:38PM +0800, yu kuai wrote:
> > > Fixes gcc '-Wunused-but-set-variable' warning:
> > > 
> > > drivers/fpga/dfl-fme-main.c: In function ‘fme_dev_destroy’:
> > > drivers/fpga/dfl-fme-main.c:678:18: warning: variable ‘fme’ set but not
> > > used [-Wunused-but-set-variable]
> > > 
> > > It is never used and so can be removed.
> > > 
> > > Signed-off-by: yu kuai <yukuai3@huawei.com>
> > > ---
> > >  drivers/fpga/dfl-fme-main.c | 2 --
> > >  1 file changed, 2 deletions(-)
> > > 
> > > diff --git a/drivers/fpga/dfl-fme-main.c b/drivers/fpga/dfl-fme-main.c
> > > index 7c930e6b314d..1d4690c99268 100644
> > > --- a/drivers/fpga/dfl-fme-main.c
> > > +++ b/drivers/fpga/dfl-fme-main.c
> > > @@ -675,10 +675,8 @@ static int fme_dev_init(struct platform_device *pdev)
> > >  static void fme_dev_destroy(struct platform_device *pdev)
> > >  {
> > >  	struct dfl_feature_platform_data *pdata = dev_get_platdata(&pdev->dev);
> > > -	struct dfl_fme *fme;
> > >  
> > >  	mutex_lock(&pdata->lock);
> > > -	fme = dfl_fpga_pdata_get_private(pdata);
> > >  	dfl_fpga_pdata_set_private(pdata, NULL);
> > >  	mutex_unlock(&pdata->lock);
> > >  }
> > > -- 
> > > 2.17.2
> > > 
> > Acked-by: Moritz Fischer <mdf@kernel.org>
> 
> Acked-by: Wu Hao <hao.wu@intel.com>
> 
> Thanks
> Hao
> 
> > 
> > Thanks,
> > Moritz

Applied to for-next.

Thanks,
Moritz
