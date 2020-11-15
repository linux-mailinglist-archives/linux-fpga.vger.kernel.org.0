Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 549EC2B3876
	for <lists+linux-fpga@lfdr.de>; Sun, 15 Nov 2020 20:21:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727527AbgKOTVI (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 15 Nov 2020 14:21:08 -0500
Received: from mail-pf1-f181.google.com ([209.85.210.181]:40376 "EHLO
        mail-pf1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727418AbgKOTVI (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 15 Nov 2020 14:21:08 -0500
Received: by mail-pf1-f181.google.com with SMTP id w14so11327823pfd.7;
        Sun, 15 Nov 2020 11:21:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1r/5zes/ZNeiDOhwDFXJZan/EFt94KTzKd4mDIl9p/c=;
        b=iUPKKsNl9UGk5nmXN4ONlArMZkvb2/jbgzGJmwZwNcbrVGWDpMsRHH4CL8p4rVRjJJ
         L7V2hfBeqwP3I8Zm9lekNr9Oq5eEqPexviQPdhOVV18AwBP7SRO/EAOGmpcP1/Kiqj0Q
         7IVgG33FF32v+abErd/DfXkgt+G51DPbNeED5e/p3jc+eA4kuPGKfWj03f5sUusbWXK1
         zcVOdo8lRBz1rUqgkU7D1KOTBYCRimPsWc9UNsK3o7fnoZA0iGYfQl3BkmmqCzpMhJXi
         siqi8a3gzN5uKOQ5wIaTwccEFEqWNu5tkMi0HnY6le0YQciWWMPpKfB6Z7ihef1/NFyO
         h7hg==
X-Gm-Message-State: AOAM530g1trzOWaXTTkLGR5nCQxhVDacSOzXt0JBlz2exwwXx9oyuUuA
        01+zatqL3rBwoakJ8M4IC2TwrCTnzfk=
X-Google-Smtp-Source: ABdhPJwkIRdJbOKXQE4RONSfzD1F5xy2Bo7mRUXSborDW2+o71A57wU5YDaZXgwrEAODYFOSzjzkLQ==
X-Received: by 2002:a63:381:: with SMTP id 123mr10640542pgd.112.1605468067918;
        Sun, 15 Nov 2020 11:21:07 -0800 (PST)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id r2sm15457719pji.55.2020.11.15.11.21.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2020 11:21:07 -0800 (PST)
Date:   Sun, 15 Nov 2020 11:21:06 -0800
From:   Moritz Fischer <mdf@kernel.org>
To:     richard.gong@linux.intel.com
Cc:     mdf@kernel.org, trix@redhat.com, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, dinguyen@kernel.org,
        sridhar.rajagopal@intel.com, Richard Gong <richard.gong@intel.com>
Subject: Re: [PATCHv1 3/4] dt-bindings: fpga: add authenticate-fpga-config
 property
Message-ID: <20201115192106.GB283592@epycbox.lan>
References: <1605204403-6663-1-git-send-email-richard.gong@linux.intel.com>
 <1605204403-6663-4-git-send-email-richard.gong@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1605204403-6663-4-git-send-email-richard.gong@linux.intel.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Richard,

On Thu, Nov 12, 2020 at 12:06:42PM -0600, richard.gong@linux.intel.com wrote:
> From: Richard Gong <richard.gong@intel.com>
> 
> Add authenticate-fpga-config property for FPGA bitstream authentication.
> 
> Signed-off-by: Richard Gong <richard.gong@intel.com>
> ---
>  Documentation/devicetree/bindings/fpga/fpga-region.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/fpga/fpga-region.txt b/Documentation/devicetree/bindings/fpga/fpga-region.txt
> index e811cf8..7a512bc 100644
> --- a/Documentation/devicetree/bindings/fpga/fpga-region.txt
> +++ b/Documentation/devicetree/bindings/fpga/fpga-region.txt
> @@ -187,6 +187,7 @@ Optional properties:
>  - external-fpga-config : boolean, set if the FPGA has already been configured
>  	prior to OS boot up.
>  - encrypted-fpga-config : boolean, set if the bitstream is encrypted
> +- authenticate-fpga-config : boolean, set if do bitstream authentication
It is unclear to me from the description whether this entails
authentication + reconfiguration or just authentication.

If the latter is the case this should probably be described as such.

>  - region-unfreeze-timeout-us : The maximum time in microseconds to wait for
>  	bridges to successfully become enabled after the region has been
>  	programmed.
> -- 
> 2.7.4
> 

Thanks
