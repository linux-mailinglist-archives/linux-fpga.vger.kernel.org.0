Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D581A1E9A3C
	for <lists+linux-fpga@lfdr.de>; Sun, 31 May 2020 21:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbgEaTtb (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 31 May 2020 15:49:31 -0400
Received: from mail-pg1-f178.google.com ([209.85.215.178]:43343 "EHLO
        mail-pg1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726882AbgEaTta (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 31 May 2020 15:49:30 -0400
Received: by mail-pg1-f178.google.com with SMTP id 185so2504029pgb.10;
        Sun, 31 May 2020 12:49:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4shVeq4P49QY+lf67oVac1QZQRNqssGFZQ4bP+zIwn0=;
        b=qcfA1AUrC+ztxFWUd52+fKk7vSxfD/Mah+2gd1EqrlG4/0p3xuELsmUiCmEBNuhB8A
         C3g2YxLwgRWM0i7Dfa9q9ty4mdrG1jtRteWxmLf3RVq3Vm5nqLcs2LHm81RKzzkkSUXB
         yRyh/L9gCwL5GalQgjmT4B8Tbfxky+/7joYAdzPZ9svd5SFst66Z/KcYBwuCvLtzTxZQ
         DZSf8zsgEgdbYRYwvmhXhW3l/Lj0zWiFdBC3JHYPfeBxiBNDIziLqXNcFRkjddoJoNAX
         uH4glytqaYIrsYSTHCntN7BcIrFYXYpN+LJhOI0JFD5iEiKYxaaxz+cB/0IjpAGnXfKU
         4BAw==
X-Gm-Message-State: AOAM5336CvlaExIvRZo5gLTS02bnIYf0ALVWyJtjS2SWDpZ46SbRncA9
        AskkX7Tf4xEhJvPU0UKctZA=
X-Google-Smtp-Source: ABdhPJyxTkPwQbgpcvj/x3N9tmG2azUK2w4ADAEZ4CY+504PgsjpV2xVBqUaQSVE/W3+Os0OpWrNoA==
X-Received: by 2002:a62:342:: with SMTP id 63mr16981848pfd.229.1590954569787;
        Sun, 31 May 2020 12:49:29 -0700 (PDT)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id v5sm5787722pjy.4.2020.05.31.12.49.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2020 12:49:28 -0700 (PDT)
Date:   Sun, 31 May 2020 12:49:27 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     Richard Gong <richard.gong@linux.intel.com>
Cc:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, dinguyen@kernel.org,
        Richard Gong <richard.gong@intel.com>
Subject: Re: [PATCHv2] fpga: stratix10-soc: remove the pre-set
 reconfiguration condition
Message-ID: <20200531194927.GA1622@epycbox.lan>
References: <1589553303-7341-1-git-send-email-richard.gong@linux.intel.com>
 <1d9b21df-7421-b25e-5139-f297e24d99d4@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d9b21df-7421-b25e-5139-f297e24d99d4@linux.intel.com>
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Fri, May 29, 2020 at 08:15:15AM -0500, Richard Gong wrote:
> Hi Moritz,
> 
> Sorry for asking.
> 
> When you get chance, can you review my version 2 patch submitted on
> 05/15/20?
> 
> Regards,
> Richard
> 
> On 5/15/20 9:35 AM, richard.gong@linux.intel.com wrote:
> > From: Richard Gong <richard.gong@intel.com>
> > 
> > The reconfiguration mode is pre-set by driver as the full reconfiguration.
> > As a result, user have to change code and recompile the drivers if he or
> > she wants to perform a partial reconfiguration. Removing the pre-set
> > reconfiguration condition so that user can select full or partial
> > reconfiguration via overlay device tree without recompiling the drivers.

Can you help me understand? See comment below, I'm not sure how this
change changes the behavior.
> > 
> > Also add an error message if the configuration request is failure.
> > 
> > Signed-off-by: Richard Gong <richard.gong@intel.com>
> > ---
> > v2: define and use constant values
> > ---
> >   drivers/fpga/stratix10-soc.c | 9 +++++++--
> >   1 file changed, 7 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/fpga/stratix10-soc.c b/drivers/fpga/stratix10-soc.c
> > index 44b7c56..4d52a80 100644
> > --- a/drivers/fpga/stratix10-soc.c
> > +++ b/drivers/fpga/stratix10-soc.c
> > @@ -14,9 +14,13 @@
> >   /*
> >    * FPGA programming requires a higher level of privilege (EL3), per the SoC
> >    * design.
> > + * SoC firmware supports full and partial reconfiguration.
Consider:
"The SoC firmware supports full and partial reconfiguration."
> >    */
> >   #define NUM_SVC_BUFS	4
> >   #define SVC_BUF_SIZE	SZ_512K
> > +#define FULL_RECONFIG_FLAG	0
> > +#define PARTIAL_RECONFIG_FLAG	1
> > +
> >   /* Indicates buffer is in use if set */
> >   #define SVC_BUF_LOCK	0
> > @@ -182,12 +186,12 @@ static int s10_ops_write_init(struct fpga_manager *mgr,
> >   	uint i;
> >   	int ret;
> > -	ctype.flags = 0;
> >   	if (info->flags & FPGA_MGR_PARTIAL_RECONFIG) {
> >   		dev_dbg(dev, "Requesting partial reconfiguration.\n");
> > -		ctype.flags |= BIT(COMMAND_RECONFIG_FLAG_PARTIAL);
> > +		ctype.flags = PARTIAL_RECONFIG_FLAG;
> >   	} else {
> >   		dev_dbg(dev, "Requesting full reconfiguration.\n");
> > +		ctype.flags = FULL_RECONFIG_FLAG;
> >   	}
Am I missing something here: Doesn't this do the same as before?

Before:
If info->flags & FPGA_MGR_PARTIAL_RECONFIG -> ctype.flags = 0 |
BIT(COMMAND_RECONFIG_FLAG_PARTIAL) -> 1
and ctype->flags = FULL_RECONFIG -> 0 else.

Now:
If info->flags & FPGA_MGR_PARTIAL_RECONFIG -> ctype.flags = PARTIAL_RECONFIG_FLAG -> 1
ctype->flags = FULL_REECONFIG_FLAG -> 0 else.

Am I missing something here? If I don't set the flag for partial
reconfig I'd end up with full reconfiguration in both cases?
If I do set the flag, I get partial reconfiguration in both cases?

> >   	reinit_completion(&priv->status_return_completion);
> > @@ -210,6 +214,7 @@ static int s10_ops_write_init(struct fpga_manager *mgr,
> >   	ret = 0;
> >   	if (!test_and_clear_bit(SVC_STATUS_OK, &priv->status)) {
> > +		dev_err(dev, "RECONFIG_REQUEST failed\n");
> >   		ret = -ETIMEDOUT;
> >   		goto init_done;
> >   	}
> > 

Thanks,
Moritz
