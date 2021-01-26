Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37B1030514F
	for <lists+linux-fpga@lfdr.de>; Wed, 27 Jan 2021 05:48:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239536AbhA0Epb (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 26 Jan 2021 23:45:31 -0500
Received: from mail-pj1-f44.google.com ([209.85.216.44]:50187 "EHLO
        mail-pj1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbhAZFGE (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 26 Jan 2021 00:06:04 -0500
Received: by mail-pj1-f44.google.com with SMTP id md11so1347903pjb.0;
        Mon, 25 Jan 2021 21:05:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IcrHLqPjMXBnF6rfs3M/DpvPUrrPqGUGDQ5xD1fyZU4=;
        b=Y1YrR4kw9a2VAijwdLdfqSwAet6QmBU6TAa3wIuwHG76Dhrxe4TajX1Aav7LtI352F
         HGih/7qBunzvwcUWRi1nUwH1BrRLjpr64B2GqDWBvcYSxYf48ZQhY+XAlQ5OyOAheqys
         4Rwnq34fca4lk8f5PmP+hj7Cm878qpzeoNOcDiC1cHAz4T3OtgJwacxJgZoS9vk2v8pX
         XLfAIRopqR6wkgAp6h/rWpnmvF0nvCUdbwVI5wjf1TOSOhGCpw7zEZJRKqO69piv5FWx
         ZHI5oCtzZYHRIi1j0LbZabFWJ2AQBUriCJsXtUhKE4QXbAxgGviB+Jj0BKirak7AEO90
         Yb6A==
X-Gm-Message-State: AOAM5317MALhibbWi2tQZ2MowGmWwhcE0giuuIxnRrnsu2nepJEGkBxl
        3mTGD4fo/dJ2sgwqGta2g7Y=
X-Google-Smtp-Source: ABdhPJzLgwil+6sXtWQLhCstqXygI1Y9j2EA/2WKHTOeHKabmV/MYdbcH+dreOD9oCv/D7SdU9Cu1g==
X-Received: by 2002:a17:90b:4b86:: with SMTP id lr6mr4041168pjb.107.1611637524170;
        Mon, 25 Jan 2021 21:05:24 -0800 (PST)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id gk2sm931207pjb.6.2021.01.25.21.05.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 21:05:23 -0800 (PST)
Date:   Mon, 25 Jan 2021 21:05:21 -0800
From:   Moritz Fischer <mdf@kernel.org>
To:     richard.gong@linux.intel.com
Cc:     mdf@kernel.org, trix@redhat.com, gregkh@linuxfoundation.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        dinguyen@kernel.org, sridhar.rajagopal@intel.com,
        Richard Gong <richard.gong@intel.com>
Subject: Re: [PATCHv3 5/6] dt-bindings: fpga: add authenticate-fpga-config
 property
Message-ID: <YA+jESIpV/cRTECe@epycbox.lan>
References: <1611608188-25621-1-git-send-email-richard.gong@linux.intel.com>
 <1611608188-25621-6-git-send-email-richard.gong@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1611608188-25621-6-git-send-email-richard.gong@linux.intel.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Mon, Jan 25, 2021 at 02:56:27PM -0600, richard.gong@linux.intel.com wrote:
> From: Richard Gong <richard.gong@intel.com>
> 
> Add authenticate-fpga-config property for FPGA bitstream authentication,
> which makes sure a signed bitstream has valid signatures.
> 
> Signed-off-by: Richard Gong <richard.gong@intel.com>
> ---
> v3: no change
> v2: put authenticate-fpga-config above partial-fpga-config
>     update commit messages
> ---
>  Documentation/devicetree/bindings/fpga/fpga-region.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/fpga/fpga-region.txt b/Documentation/devicetree/bindings/fpga/fpga-region.txt
> index e811cf8..d0d3234 100644
> --- a/Documentation/devicetree/bindings/fpga/fpga-region.txt
> +++ b/Documentation/devicetree/bindings/fpga/fpga-region.txt
> @@ -182,6 +182,7 @@ Optional properties:
>  	This property is optional if the FPGA Manager handles the bridges.
>          If the fpga-region is  the child of a fpga-bridge, the list should not
>          contain the parent bridge.
> +- authenticate-fpga-config : boolean, set if do bitstream authentication only.
I don't understand. Can I do authenticate-fpga-config AND
partial-fpga-config?
>  - partial-fpga-config : boolean, set if partial reconfiguration is to be done,
>  	otherwise full reconfiguration is done.
>  - external-fpga-config : boolean, set if the FPGA has already been configured
> -- 
> 2.7.4
> 
Please clarify,

Moritz
