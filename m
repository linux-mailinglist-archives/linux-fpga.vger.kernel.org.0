Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1CE1816B5E
	for <lists+linux-fpga@lfdr.de>; Tue,  7 May 2019 21:31:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbfEGTb6 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 7 May 2019 15:31:58 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36103 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726000AbfEGTb6 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 7 May 2019 15:31:58 -0400
Received: by mail-pg1-f194.google.com with SMTP id 85so8809589pgc.3
        for <linux-fpga@vger.kernel.org>; Tue, 07 May 2019 12:31:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+BHeCC0KibMuGQaQ13pNV0ld+sIiRc+E9RP4V7KGKCA=;
        b=eLWnJEvaHEutdbeXdXxUv6DyNu+eUN8THEezsGaZCi2+H81DNehc9Oov9fShjTkbmk
         nNq6r0Iy185mpNklGE+7ZLgopnq1qBKPwjAHXMpLr6sxKxZ/BAGiZUDIB5a5Rk8JEio0
         MKLPihe3bpRUUPtZdn6IIa5sbgDDE5tnwJNVEq2tUek6qwff/Olwk7d0xh0BzwwvkF5f
         xBQCxbkOkK7331WYffrYS27VLj7WGZVIebAxYSi5/4hLzNCPcoT0E2jnELqcpJpXi5ax
         mkKXq+jPDsuiNpQ3nBmDkRN0PEOGcsOJ5kvx8CXiemUKNNLCNwf/QZxrfZFQIOFCOyQU
         Mlyg==
X-Gm-Message-State: APjAAAWlTPpaHQU8Iuv1eqEsY6EVwQSnGaDb/E4o8YVxx71iOeseRFqH
        2eWPStPeJFMZUNKkOZmsRnaJ4w==
X-Google-Smtp-Source: APXvYqzBLzsZYmzhOtRcPH8guMtfDVgap2dm+RKSPAKoX63LYVwZrff17koc4QYNdq+YQtiKmPRMzg==
X-Received: by 2002:aa7:8dc7:: with SMTP id j7mr42767214pfr.82.1557257516723;
        Tue, 07 May 2019 12:31:56 -0700 (PDT)
Received: from localhost ([2601:647:4700:2953:ec49:968:583:9f8])
        by smtp.gmail.com with ESMTPSA id q17sm35415411pfi.185.2019.05.07.12.31.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 May 2019 12:31:55 -0700 (PDT)
Date:   Tue, 7 May 2019 12:31:54 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     Alan Tull <atull@kernel.org>
Cc:     Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH] fpga: zynqmp-fpga: Correctly handle error pointer
Message-ID: <20190507193154.GB30078@archbox>
References: <20190507170257.25451-1-mdf@kernel.org>
 <CANk1AXS2m+v2uMoE0gLhKqYhn_NcbV8gZq+ogMsC_Zp81ZHAow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANk1AXS2m+v2uMoE0gLhKqYhn_NcbV8gZq+ogMsC_Zp81ZHAow@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Alan,

On Tue, May 07, 2019 at 02:11:06PM -0500, Alan Tull wrote:
> On Tue, May 7, 2019 at 12:03 PM Moritz Fischer <mdf@kernel.org> wrote:
> 
> Hi Moritz,
> 
> >
> > Fixes the following static checker error:
> >
> > drivers/fpga/zynqmp-fpga.c:50 zynqmp_fpga_ops_write()
> > error: 'eemi_ops' dereferencing possible ERR_PTR()
> >
> > Note: This does not handle the EPROBE_DEFER value in a
> >       special manner.
> >
> > Fixes commit c09f7471127e ("fpga manager: Adding FPGA Manager support for
> > Xilinx zynqmp")
> > Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> > Signed-off-by: Moritz Fischer <mdf@kernel.org>
> > ---
> >  drivers/fpga/zynqmp-fpga.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/fpga/zynqmp-fpga.c b/drivers/fpga/zynqmp-fpga.c
> > index f7cbaadf49ab..abcb0b2e75bf 100644
> > --- a/drivers/fpga/zynqmp-fpga.c
> > +++ b/drivers/fpga/zynqmp-fpga.c
> > @@ -47,7 +47,7 @@ static int zynqmp_fpga_ops_write(struct fpga_manager *mgr,
> >         char *kbuf;
> >         int ret;
> >
> > -       if (!eemi_ops || !eemi_ops->fpga_load)
> > +       if (IS_ERR_OR_NULL(eemi_ops) || !eemi_ops->fpga_load)
> 
> This if statement also happens in fpga_mgr_states
> zynqmp_fpga_ops_state(), so we'll need this fix there also.

Good catch, will fix in v2.

Thanks
Moritz
