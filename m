Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 467FA365FC2
	for <lists+linux-fpga@lfdr.de>; Tue, 20 Apr 2021 20:49:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233540AbhDTSuD (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 20 Apr 2021 14:50:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20599 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233509AbhDTSuC (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 20 Apr 2021 14:50:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618944570;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xTY0mCG2eJ3mroHBIYuOAHHk6rEx5dTSoq0fQL3Qaqo=;
        b=BaUF04gd7rKhTVpSYVFEZRQQEqrRuE7M6CWVDzHIm3x8Z44x9Pat/MaZn7tJ3TBTBHTNol
        5nCZEUc1g4HayvjlxIsKRzI0GpxDlX+KlfURVbGfFu4VwKQQLgyDPBnBVhIwhMjGeWw8go
        uRHV/dOkDroKLNvu7lki1A+4cIFC4sA=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-363-Mz-aJiwcNuiBsw0mOmp-eg-1; Tue, 20 Apr 2021 14:49:24 -0400
X-MC-Unique: Mz-aJiwcNuiBsw0mOmp-eg-1
Received: by mail-qk1-f200.google.com with SMTP id e4-20020a37b5040000b02902df9a0070efso7893616qkf.18
        for <linux-fpga@vger.kernel.org>; Tue, 20 Apr 2021 11:49:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=xTY0mCG2eJ3mroHBIYuOAHHk6rEx5dTSoq0fQL3Qaqo=;
        b=h0MUfwTC3w930sTPMji49oK4BzN8zWJOuY1fIzgP9CJdrRtaEQ/jkYRDLSubVqkW3l
         qmNjjBtpQOjk4xZp5t17Xi0JMYGoKRQUkLMONpLUdQ26CZGzOu/MuokLQnGb+k+lrjvN
         PU3IgIp0S+CtBhyb7cqco4Kdkq2m5mxl2yaNqLEidtsCskYATQP3cdtJaKrzfc2NC2aF
         MCGcEun/uYbiamfioFQt6tlXV9OvF1vIKU06zEsKJ+cBmkVIysyC0X/IkH8YR9XS8Swc
         eTEYi+F81hlFWY2E3bL/OQ5+HekGL3nurAOr3wc2x9aF9KT+n6W7ZCHHcNaYnEL2SXZ4
         o6ug==
X-Gm-Message-State: AOAM530GktXO39PpwgQ6a3i2Jg+ijcXkzzDdoZiVMROlRzj9mgUJchCg
        h5/GFrmki9p0+I37qYExqecwXejfdCWjQ4zDSS3Mu1L2SEcn3xKs6zZYXxqs8IXIqDpKDfPiL8S
        0blMDGU5wdAHHTxeieKX22g==
X-Received: by 2002:ad4:4c86:: with SMTP id bs6mr28831582qvb.39.1618944563941;
        Tue, 20 Apr 2021 11:49:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzusiqTCXDlAzOxJKugREvcfx9N/z6bzc64freSXmRHNCZ3wuqqpeBKBCH+U+qO7KoZZiuq7A==
X-Received: by 2002:ad4:4c86:: with SMTP id bs6mr28831564qvb.39.1618944563708;
        Tue, 20 Apr 2021 11:49:23 -0700 (PDT)
Received: from localhost.localdomain (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id b23sm1961110qtp.17.2021.04.20.11.49.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Apr 2021 11:49:23 -0700 (PDT)
Subject: Re: [PATCH] fpga: dfl: pci: gracefully handle misconfigured port
 entries
To:     matthew.gerlach@linux.intel.com, hao.wu@intel.com,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        yilun.xu@intel.com, russell.h.weight@intel.com, mdf@kernel.org
References: <20210420172740.707259-1-matthew.gerlach@linux.intel.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <3f6f683d-8bd2-6394-e9ae-7cb0d1cd7bdd@redhat.com>
Date:   Tue, 20 Apr 2021 11:49:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210420172740.707259-1-matthew.gerlach@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 4/20/21 10:27 AM, matthew.gerlach@linux.intel.com wrote:
> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>
> Gracefully ignore misconfigured port entries encountered in
> incorrect FPGA images.
>
> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> ---
>   drivers/fpga/dfl-pci.c | 16 +++++++++++++++-
>   1 file changed, 15 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/fpga/dfl-pci.c b/drivers/fpga/dfl-pci.c
> index b44523e..660d3b6 100644
> --- a/drivers/fpga/dfl-pci.c
> +++ b/drivers/fpga/dfl-pci.c
> @@ -212,6 +212,7 @@ static int find_dfls_by_default(struct pci_dev *pcidev,
Does something similar need to be added to find_dfls_by_vsec ?
>   	int port_num, bar, i, ret = 0;
>   	resource_size_t start, len;
>   	void __iomem *base;
> +	int bars = 0;
>   	u32 offset;
>   	u64 v;
>   
> @@ -228,6 +229,7 @@ static int find_dfls_by_default(struct pci_dev *pcidev,
>   	if (dfl_feature_is_fme(base)) {
>   		start = pci_resource_start(pcidev, 0);
>   		len = pci_resource_len(pcidev, 0);
> +		bars |= BIT(0);
>   
>   		dfl_fpga_enum_info_add_dfl(info, start, len);
>   
> @@ -253,9 +255,21 @@ static int find_dfls_by_default(struct pci_dev *pcidev,
>   			 */
>   			bar = FIELD_GET(FME_PORT_OFST_BAR_ID, v);
>   			offset = FIELD_GET(FME_PORT_OFST_DFH_OFST, v);
> +			if (bars & BIT(bar)) {
> +				dev_warn(&pcidev->dev, "skipping bad port BAR %d\n", bar);
> +				continue;
> +			}
> +
>   			start = pci_resource_start(pcidev, bar) + offset;
> -			len = pci_resource_len(pcidev, bar) - offset;
> +			len = pci_resource_len(pcidev, bar);
> +			if (offset >= len) {
> +				dev_warn(&pcidev->dev, "bad port offset %u >= %pa\n",
> +					 offset, &len);

why %pa,&len for instead of %u,len ?

Tom

> +				continue;
> +			}
>   
> +			len -= offset;
> +			bars |= BIT(bar);
>   			dfl_fpga_enum_info_add_dfl(info, start, len);
>   		}
>   	} else if (dfl_feature_is_port(base)) {

