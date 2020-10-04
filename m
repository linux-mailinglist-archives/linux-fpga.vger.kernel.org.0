Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 433EF282E5B
	for <lists+linux-fpga@lfdr.de>; Mon,  5 Oct 2020 01:40:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725862AbgJDXkK (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 4 Oct 2020 19:40:10 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:36736 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbgJDXkK (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 4 Oct 2020 19:40:10 -0400
Received: by mail-pj1-f66.google.com with SMTP id b17so4305400pji.1;
        Sun, 04 Oct 2020 16:40:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5RmC8lajvDc8JqqhpPvdF9cVFad8GQY7C5ZedFzF2D4=;
        b=JmxdNQntLN03I9Vcw9bZquYFA74wnb16vYw/UpL7TNZsZjFLB5d0GJ21B9WtGYG0Yv
         ZzARxCk6RqDIzFHfWooVWsBQezDB6RDexwbzBkWx0n8iFllsOnwIagtvL5qV8t/M40Qc
         roPflBYqYR/+MGaVKjYrJm0Izn8n7/LMgiXKeyQH5ZkkXlqnFwBx08ouSr2a/EB4NWBa
         OcUwpjdedVhnW7T6q2gJiRRm9VNf73/LGAWhKGV/T9pZ7mN1jSA4tDOQ+B/MNOV9JDHC
         r1eg5jrzthUuWyjYyFrch4flqsNpWLsR/eIPoyVoVQgXZ+jfnAbuOY4T7pogfMmBKKiu
         t/Fw==
X-Gm-Message-State: AOAM531OMo5tDAEMsMBE9gox9hcjNFqz7lAqqRXX3e0Qs+zN54MfKra8
        pmZfB4vt8qYwudOGGurtMNI=
X-Google-Smtp-Source: ABdhPJwzpONdJUJJVy488Qvmo0+TrrapgrC7zUxvxXWZByizaGqJE/ZtWk2CB+oYu7/wLlyCfnG5JA==
X-Received: by 2002:a17:90a:aa05:: with SMTP id k5mr13402380pjq.59.1601854809620;
        Sun, 04 Oct 2020 16:40:09 -0700 (PDT)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id x22sm7652583pfp.181.2020.10.04.16.40.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2020 16:40:09 -0700 (PDT)
Date:   Sun, 4 Oct 2020 16:40:08 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     Tom Rix <trix@redhat.com>
Cc:     Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org,
        hao.wu@intel.com, michal.simek@xilinx.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        russell.h.weight@intel.com, matthew.gerlach@intel.com
Subject: Re: [PATCH 03/10] fpga: fpga-mgr: dfl-fme-mgr: Simplify registration
Message-ID: <20201004234008.GB111357@epycbox.lan>
References: <20201004051423.75879-1-mdf@kernel.org>
 <20201004051423.75879-4-mdf@kernel.org>
 <408267d9-1026-1a80-56c9-3a8beaaa2b82@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <408267d9-1026-1a80-56c9-3a8beaaa2b82@redhat.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Sun, Oct 04, 2020 at 11:22:31AM -0700, Tom Rix wrote:
> 
> On 10/3/20 10:14 PM, Moritz Fischer wrote:
> > Simplify registration using new devm_fpga_mgr_register() API.
> >
> > Signed-off-by: Moritz Fischer <mdf@kernel.org>
> > ---
> >  drivers/fpga/dfl-fme-mgr.c | 12 +-----------
> >  1 file changed, 1 insertion(+), 11 deletions(-)
> >
> > diff --git a/drivers/fpga/dfl-fme-mgr.c b/drivers/fpga/dfl-fme-mgr.c
> > index b3f7eee3c93f..3fc2be87d059 100644
> > --- a/drivers/fpga/dfl-fme-mgr.c
> > +++ b/drivers/fpga/dfl-fme-mgr.c
> > @@ -316,16 +316,7 @@ static int fme_mgr_probe(struct platform_device *pdev)
> >  	mgr->compat_id = compat_id;
> >  	platform_set_drvdata(pdev, mgr);
> 
Nice catch. Will fix.
> Is this call is still needed ?
> 
> Tom
> 
> >  
> > -	return fpga_mgr_register(mgr);
> > -}
> > -
> > -static int fme_mgr_remove(struct platform_device *pdev)
> > -{
> > -	struct fpga_manager *mgr = platform_get_drvdata(pdev);
> > -
> > -	fpga_mgr_unregister(mgr);
> > -
> > -	return 0;
> > +	return devm_fpga_mgr_register(dev, mgr);
> >  }
> >  
> >  static struct platform_driver fme_mgr_driver = {
> > @@ -333,7 +324,6 @@ static struct platform_driver fme_mgr_driver = {
> >  		.name    = DFL_FPGA_FME_MGR,
> >  	},
> >  	.probe   = fme_mgr_probe,
> > -	.remove  = fme_mgr_remove,
> >  };
> >  
> >  module_platform_driver(fme_mgr_driver);
> 

Cheers,
Moritz
