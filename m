Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF2BC282C7B
	for <lists+linux-fpga@lfdr.de>; Sun,  4 Oct 2020 20:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbgJDSWh (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 4 Oct 2020 14:22:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31687 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726288AbgJDSWh (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 4 Oct 2020 14:22:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601835756;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E+z+3QnpezIdPFc/Jyz8I8pdkhO58upU4jK8SfFO6pE=;
        b=GdVCYPMMxRVtm+Dyt8bSQyyS8bUkDkgctcEDPj24CqH96Vf514PzK2LCk+bh822E+4O2/G
        pmvzku7ISnCO7LrlU1nMfrd+x/ulqLWBdN4j/2y289Iecs7Dub7jOs+zX4kZwwm+oX+iy/
        HR/NU50pzpD67aNfCTE3GaxFTQOy5Fw=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-93-R2iyq-3uPVaaFtH-6-BNUg-1; Sun, 04 Oct 2020 14:22:34 -0400
X-MC-Unique: R2iyq-3uPVaaFtH-6-BNUg-1
Received: by mail-qk1-f198.google.com with SMTP id m203so5054512qke.16
        for <linux-fpga@vger.kernel.org>; Sun, 04 Oct 2020 11:22:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=E+z+3QnpezIdPFc/Jyz8I8pdkhO58upU4jK8SfFO6pE=;
        b=eT6AN9UqVVdISuZOHFeteLOORpUn5Wu22CY00cTgcy7FhJ8xX63Nbb18kgMEILI89d
         edgRXKFwfvP38FhD5cypH+/2oN0Stxt7oev84JphLpPwRkq4f7RFQrEPR7CYZ5sc1nUx
         SYN4Tx3lvpaJX8CWho26ppX41eBYPtDBlFzlLeS3AZhbOisYlvZYbeWUZkmHULeMfcWj
         udfxWxintafcLhGZyWB6a+zl/l95r13airT7TeIZEC+h1EqmwpYhqYXqRq43J/bU4YOu
         gdpTd7UD3OcAZE249cFSymfAuaYrr8T7IoISHzQLwlNYzESAJJxYzT+1FRlRQQRp4y+v
         objA==
X-Gm-Message-State: AOAM531gucem66nV692qjDkJDYecZuFFvh1iouQc+pvVKjVn+igpF7kL
        LcF0uuuSFoSVXJvyXLDRdL2bjijQ92aBxqp+/PUb54sqdpgDXzRuX0gq3xznR7zJ2Z4YZilMpyp
        kLuhtPVRDAmbecNpv+tM/4w==
X-Received: by 2002:a37:9e8e:: with SMTP id h136mr561997qke.205.1601835754311;
        Sun, 04 Oct 2020 11:22:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy+HbQ8Td/estDK0M/QzXF2k7W6Atz9B+/Jr3kBLoEy9X4bEQfTw3kyfvz/jNcI428QW0FZNA==
X-Received: by 2002:a37:9e8e:: with SMTP id h136mr561979qke.205.1601835754127;
        Sun, 04 Oct 2020 11:22:34 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id p187sm5625268qkd.129.2020.10.04.11.22.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Oct 2020 11:22:33 -0700 (PDT)
Subject: Re: [PATCH 03/10] fpga: fpga-mgr: dfl-fme-mgr: Simplify registration
To:     Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org
Cc:     hao.wu@intel.com, michal.simek@xilinx.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        russell.h.weight@intel.com, matthew.gerlach@intel.com
References: <20201004051423.75879-1-mdf@kernel.org>
 <20201004051423.75879-4-mdf@kernel.org>
From:   Tom Rix <trix@redhat.com>
Message-ID: <408267d9-1026-1a80-56c9-3a8beaaa2b82@redhat.com>
Date:   Sun, 4 Oct 2020 11:22:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20201004051423.75879-4-mdf@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 10/3/20 10:14 PM, Moritz Fischer wrote:
> Simplify registration using new devm_fpga_mgr_register() API.
>
> Signed-off-by: Moritz Fischer <mdf@kernel.org>
> ---
>  drivers/fpga/dfl-fme-mgr.c | 12 +-----------
>  1 file changed, 1 insertion(+), 11 deletions(-)
>
> diff --git a/drivers/fpga/dfl-fme-mgr.c b/drivers/fpga/dfl-fme-mgr.c
> index b3f7eee3c93f..3fc2be87d059 100644
> --- a/drivers/fpga/dfl-fme-mgr.c
> +++ b/drivers/fpga/dfl-fme-mgr.c
> @@ -316,16 +316,7 @@ static int fme_mgr_probe(struct platform_device *pdev)
>  	mgr->compat_id = compat_id;
>  	platform_set_drvdata(pdev, mgr);

Is this call is still needed ?

Tom

>  
> -	return fpga_mgr_register(mgr);
> -}
> -
> -static int fme_mgr_remove(struct platform_device *pdev)
> -{
> -	struct fpga_manager *mgr = platform_get_drvdata(pdev);
> -
> -	fpga_mgr_unregister(mgr);
> -
> -	return 0;
> +	return devm_fpga_mgr_register(dev, mgr);
>  }
>  
>  static struct platform_driver fme_mgr_driver = {
> @@ -333,7 +324,6 @@ static struct platform_driver fme_mgr_driver = {
>  		.name    = DFL_FPGA_FME_MGR,
>  	},
>  	.probe   = fme_mgr_probe,
> -	.remove  = fme_mgr_remove,
>  };
>  
>  module_platform_driver(fme_mgr_driver);

