Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE60030514C
	for <lists+linux-fpga@lfdr.de>; Wed, 27 Jan 2021 05:48:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238597AbhA0Epi (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 26 Jan 2021 23:45:38 -0500
Received: from mail-pl1-f180.google.com ([209.85.214.180]:44890 "EHLO
        mail-pl1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728344AbhAZFLO (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 26 Jan 2021 00:11:14 -0500
Received: by mail-pl1-f180.google.com with SMTP id r4so9154876pls.11;
        Mon, 25 Jan 2021 21:10:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6Z2Az4u1rmOoRqGFz5sYMrMjNTGj+TrZ7aPQiL92Nhk=;
        b=RitPwl4qQkjD5wZfuNGT0piIaW4nYktQ6f3NgfIO6N4wL7yVDDPV6CWMgrpQ9An1Ss
         mKs0caym/BB6Y+zZGodhOb86UHllqM22fJ+mT91nMUn2AZnRCYVxlkZ3OB56UBds1cTE
         lT/cFJ1HcYeacV8wurQTi5Mq7DB1f7jyXiaat2audI1yPSwJxufSwreQ/oQhL3GZLpa0
         dMYdB8Afe7xr3aoQBB2p1NPMGtfzBjiNG9a/0n++qo+16IbmkjE7R5oRoIEj87y2UoIl
         qkj78IrQNC/LZp1Xwt0O9akaE9p6c+ZLKAZShoWSN9NL+AaHigvyL87atJDgN/BQCSP6
         pLdw==
X-Gm-Message-State: AOAM531nvJrQh8HXNv1A59tJZn3Mnl3gmpnJ8FTZ96Ggp9wyRu+oOW0n
        QMHeCf6k+jZKG80vgNoUbU8=
X-Google-Smtp-Source: ABdhPJw09/4ipOIjz/d2bLbgzSBvb/gCPL7qBnCqneXCkDC9apPuIt+j3mO6mycM6pUDoS0ih2uAbg==
X-Received: by 2002:a17:90a:c787:: with SMTP id gn7mr4067689pjb.222.1611637829060;
        Mon, 25 Jan 2021 21:10:29 -0800 (PST)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id x67sm8088107pfd.106.2021.01.25.21.10.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 21:10:28 -0800 (PST)
Date:   Mon, 25 Jan 2021 21:10:27 -0800
From:   Moritz Fischer <mdf@kernel.org>
To:     richard.gong@linux.intel.com
Cc:     mdf@kernel.org, trix@redhat.com, gregkh@linuxfoundation.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        dinguyen@kernel.org, sridhar.rajagopal@intel.com,
        Richard Gong <richard.gong@intel.com>
Subject: Re: [PATCHv3 4/6] fpga: of-fpga-region: add authenticate-fpga-config
 property
Message-ID: <YA+kQ2unznKRqp8p@epycbox.lan>
References: <1611608188-25621-1-git-send-email-richard.gong@linux.intel.com>
 <1611608188-25621-5-git-send-email-richard.gong@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1611608188-25621-5-git-send-email-richard.gong@linux.intel.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Mon, Jan 25, 2021 at 02:56:26PM -0600, richard.gong@linux.intel.com wrote:
> From: Richard Gong <richard.gong@intel.com>
> 
> Add authenticate-fpga-config property to support FPGA bitstream
> authentication, which makes sure a signed bitstream has valid signatures.
> 
> Signed-off-by: Richard Gong <richard.gong@intel.com>
> ---
> v3: no change
> v2: changed in alphabetical order
> ---
>  drivers/fpga/of-fpga-region.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/fpga/of-fpga-region.c b/drivers/fpga/of-fpga-region.c
> index e405309..3840883 100644
> --- a/drivers/fpga/of-fpga-region.c
> +++ b/drivers/fpga/of-fpga-region.c
> @@ -219,6 +219,9 @@ static struct fpga_image_info *of_fpga_region_parse_ov(
>  	info->overlay = overlay;
>  
>  	/* Read FPGA region properties from the overlay */
> +	if (of_property_read_bool(overlay, "authenticate-fpga-config"))
> +		info->flags |= FPGA_MGR_BITSTREM_AUTHENTICATION;
> +
Should you check here that no new nodes are being added as you *only*
authenticate?

>  	if (of_property_read_bool(overlay, "partial-fpga-config"))
>  		info->flags |= FPGA_MGR_PARTIAL_RECONFIG;
>  
> -- 
> 2.7.4
> 

Thanks,
Moritz
