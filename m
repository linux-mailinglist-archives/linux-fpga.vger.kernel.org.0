Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 693F136AA47
	for <lists+linux-fpga@lfdr.de>; Mon, 26 Apr 2021 03:22:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231625AbhDZBWm (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 25 Apr 2021 21:22:42 -0400
Received: from mail-pj1-f47.google.com ([209.85.216.47]:39508 "EHLO
        mail-pj1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231624AbhDZBWm (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 25 Apr 2021 21:22:42 -0400
Received: by mail-pj1-f47.google.com with SMTP id gq23-20020a17090b1057b0290151869af68bso4188630pjb.4;
        Sun, 25 Apr 2021 18:22:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5QBHfAy5goSgJOR7fp65ERjHIzK2s3HwWk7q35Co8Pc=;
        b=GvYnNuvW9fjNbBJkCfof5BoX/0xai5Bk1ye8MwMQPI/GnwKvSHDX+gpbm9J3C2kIWS
         Buz10aSbhwKQSVDq1jTRDPZN//um9GjMvtWldT5GbwjKbbXHrrBreUI8kEoXWqvaOR2E
         UDIqZBD7b3JpmptLvor+Gt9aC6h8ztmH/zKZpYvFjCvvOQQ8dy7Jd0+UvmY27uCej2X+
         5+m9jv8/Q4VBC+qLaW/aVP6eQ2WBD/4pB46XxC1iyCqaDU/E6Kpm9H0AzzqXNTArqYcY
         Xuo3ZhZnUEYOOnF5HmMYQE5TWS4TIMC6iqEtntbe49gDvogVLeK+orlt5dGnrmDOalcn
         +X2Q==
X-Gm-Message-State: AOAM531EmGdCa+xK1OEs4ojTHk70vPiFX00Qta4s6gnkHe/dVDzkzrNT
        IC73UZyAmlviSJZaHpp9dUnNDjepP64=
X-Google-Smtp-Source: ABdhPJwuSATFtk4qv61XGrUbNm9higAXH1EPB4+0ge3jSp/a0De5Pvx6LCOHlk9boktEulynai7kYA==
X-Received: by 2002:a17:902:6b05:b029:e9:2810:7e59 with SMTP id o5-20020a1709026b05b02900e928107e59mr16417718plk.76.1619400121273;
        Sun, 25 Apr 2021 18:22:01 -0700 (PDT)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id y1sm9576951pgl.88.2021.04.25.18.22.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Apr 2021 18:22:00 -0700 (PDT)
Date:   Sun, 25 Apr 2021 18:21:57 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     matthew.gerlach@linux.intel.com
Cc:     Tom Rix <trix@redhat.com>, hao.wu@intel.com,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        yilun.xu@intel.com, russell.h.weight@intel.com, mdf@kernel.org
Subject: Re: [PATCH] fpga: dfl: pci: gracefully handle misconfigured port
 entries
Message-ID: <YIYVtbgIpiH58y8H@epycbox.lan>
References: <20210420172740.707259-1-matthew.gerlach@linux.intel.com>
 <3f6f683d-8bd2-6394-e9ae-7cb0d1cd7bdd@redhat.com>
 <alpine.DEB.2.22.394.2104201217140.709797@rhweight-WRK1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2104201217140.709797@rhweight-WRK1>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Tue, Apr 20, 2021 at 12:19:42PM -0700, matthew.gerlach@linux.intel.com wrote:
> 
> 
> On Tue, 20 Apr 2021, Tom Rix wrote:
> 
> > 
> > On 4/20/21 10:27 AM, matthew.gerlach@linux.intel.com wrote:
> > > From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> > > 
> > > Gracefully ignore misconfigured port entries encountered in
> > > incorrect FPGA images.
> > > 
> > > Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> > > ---
> > >   drivers/fpga/dfl-pci.c | 16 +++++++++++++++-
> > >   1 file changed, 15 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/fpga/dfl-pci.c b/drivers/fpga/dfl-pci.c
> > > index b44523e..660d3b6 100644
> > > --- a/drivers/fpga/dfl-pci.c
> > > +++ b/drivers/fpga/dfl-pci.c
> > > @@ -212,6 +212,7 @@ static int find_dfls_by_default(struct pci_dev *pcidev,
> > Does something similar need to be added to find_dfls_by_vsec ?
> > >   	int port_num, bar, i, ret = 0;
> > >   	resource_size_t start, len;
> > >   	void __iomem *base;
> > > +	int bars = 0;
> > >   	u32 offset;
> > >   	u64 v;
> > >   @@ -228,6 +229,7 @@ static int find_dfls_by_default(struct pci_dev
> > > *pcidev,
> > >   	if (dfl_feature_is_fme(base)) {
> > >   		start = pci_resource_start(pcidev, 0);
> > >   		len = pci_resource_len(pcidev, 0);
> > > +		bars |= BIT(0);
> > >     		dfl_fpga_enum_info_add_dfl(info, start, len);
> > >   @@ -253,9 +255,21 @@ static int find_dfls_by_default(struct
> > > pci_dev *pcidev,
> > >   			 */
> > >   			bar = FIELD_GET(FME_PORT_OFST_BAR_ID, v);
> > >   			offset = FIELD_GET(FME_PORT_OFST_DFH_OFST, v);
> > > +			if (bars & BIT(bar)) {
> > > +				dev_warn(&pcidev->dev, "skipping bad port BAR %d\n", bar);
> > > +				continue;
> > > +			}
> > > +
> > >   			start = pci_resource_start(pcidev, bar) + offset;
> > > -			len = pci_resource_len(pcidev, bar) - offset;
> > > +			len = pci_resource_len(pcidev, bar);
> > > +			if (offset >= len) {
> > > +				dev_warn(&pcidev->dev, "bad port offset %u >= %pa\n",
> > > +					 offset, &len);
Do you want pa or px here?

> > 
> > why %pa,&len for instead of %u,len ?
> > 
> > Tom
> 
> Hi Tom,
> 
> The variable len is of type resource_size_t, and I am following what it says
> to do in Documentation/core-api/printk-formats.rst:
> 
> Physical address types phys_addr_t
> ----------------------------------
> 
> ::
> 
>         %pa[p]  0x01234567 or 0x0123456789abcdef
> 
> For printing a phys_addr_t type (and its derivatives, such as
> resource_size_t) which can vary based on build options, regardless of the
> width of the CPU data path.
> 
> Passed by reference.
> 
> Matthew
> > 
> > > +				continue;
> > > +			}
> > >   +			len -= offset;
> > > +			bars |= BIT(bar);
> > >   			dfl_fpga_enum_info_add_dfl(info, start, len);
> > >   		}
> > >   	} else if (dfl_feature_is_port(base)) {
> > 
> > 

- Moritz
