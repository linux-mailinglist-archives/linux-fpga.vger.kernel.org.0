Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C70773D995A
	for <lists+linux-fpga@lfdr.de>; Thu, 29 Jul 2021 01:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232392AbhG1XRv (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 28 Jul 2021 19:17:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39410 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232230AbhG1XRv (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 28 Jul 2021 19:17:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627514268;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yPDkVTZ8b83r4TbJSlWFDW+2FFM5TXW1fN7erbN+dQI=;
        b=OD+3fKIlEDj5K2HHg/7fNAF8hQum9odFT+ufLcdQgUfQqqaU77gKRNar2WUTJwgNSnn20n
        eKCcmhByFdDzPfEtC7CzmSrJaP2291IlLtHgk8G4QaXY6yGs2Gqv3iwuWOK12EcqramYd3
        18dKkU8suierzIlJlKqOJyigkbj0Mjw=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-479-LdblmV_bPnyrxkAfRHG1tA-1; Wed, 28 Jul 2021 19:17:46 -0400
X-MC-Unique: LdblmV_bPnyrxkAfRHG1tA-1
Received: by mail-qt1-f200.google.com with SMTP id m2-20020ac807c20000b0290269bd8044e1so1841548qth.10
        for <linux-fpga@vger.kernel.org>; Wed, 28 Jul 2021 16:17:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=yPDkVTZ8b83r4TbJSlWFDW+2FFM5TXW1fN7erbN+dQI=;
        b=AjYgH2GuuWvGGq8SJbfK/udVBWkbcY1DD9aexX6+usVMGA0CiORaZC0rKM3xzve3IS
         1l/E+l4b44Mckw7pLJERw7Mfhtk09zhRXxOW0avaXmEWR6/6yrsthgwNlPtP23pPNcA8
         m4RiDvLVfHWTnwAfqVjHBO6k9bG5H2qPPG3+MIZ6gAlc3glxIeKdTSISODpr26OY5eP9
         m7LdHLgE6pb3nXlMTyG4/OB1RJkAm8YUkXCciaBA4FDqmWhhsGGqHQO1jkU+680KPfBy
         R1EXk8U0v+KOGCUH0Oreugpa6sYGFy8iLL57Zrz4YRF62DQSQxuExj3rJ8plx9P/0GNX
         mvEw==
X-Gm-Message-State: AOAM533PJtOog8XEkG03wRld4uVODOcQfrxqmgeZa5i+iY9lMqHghNVp
        YT0VVjXuBYkyYDkPR0R8kgYpESfXM3rBL1lVBGCJucE2APqgpuvhMqpKlQ8ghjD8qddHDTeI4OH
        LbPiWjMY71rCD3AnSKfK7VA==
X-Received: by 2002:a37:b0a:: with SMTP id 10mr2186634qkl.291.1627514266121;
        Wed, 28 Jul 2021 16:17:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyXAgP9lkJWoLrU3pYzWQ9f0mbAUQ4I6TKaLd4nsL8jBdRO7aVFQFKVPcznO0D3SmBXEvMXYQ==
X-Received: by 2002:a37:b0a:: with SMTP id 10mr2186621qkl.291.1627514265949;
        Wed, 28 Jul 2021 16:17:45 -0700 (PDT)
Received: from localhost.localdomain (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id q184sm794947qkd.35.2021.07.28.16.17.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jul 2021 16:17:45 -0700 (PDT)
Subject: Re: [PATCH] fpga: Fix spelling mistake "eXchnage" -> "exchange" in
 Kconfig
To:     Colin King <colin.king@canonical.com>,
        Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210728215150.191914-1-colin.king@canonical.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <5e7b2e4a-aaf6-81f2-2b08-5a9adcbbee57@redhat.com>
Date:   Wed, 28 Jul 2021 16:17:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210728215150.191914-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 7/28/21 2:51 PM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>
> There is a spelling mistake in the Kconfig text. Fix it.
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>   drivers/fpga/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
> index 16793bfc2bb4..991b3f361ec9 100644
> --- a/drivers/fpga/Kconfig
> +++ b/drivers/fpga/Kconfig
> @@ -119,7 +119,7 @@ config XILINX_PR_DECOUPLER
>   	depends on HAS_IOMEM
>   	help
>   	  Say Y to enable drivers for Xilinx LogiCORE PR Decoupler
> -	  or Xilinx Dynamic Function eXchnage AIX Shutdown Manager.
> +	  or Xilinx Dynamic Function eXchange AIX Shutdown Manager.
>   	  The PR Decoupler exists in the FPGA fabric to isolate one
>   	  region of the FPGA from the busses while that region is
>   	  being reprogrammed during partial reconfig.

Looks good, thanks

Reviewed-by: Tom Rix <trix@redhat.com>

