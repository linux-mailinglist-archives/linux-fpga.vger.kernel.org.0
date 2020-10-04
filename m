Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77B75282D93
	for <lists+linux-fpga@lfdr.de>; Sun,  4 Oct 2020 22:55:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726313AbgJDUzF (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 4 Oct 2020 16:55:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56739 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726345AbgJDUzE (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 4 Oct 2020 16:55:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601844903;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mWH/ATVcRB7rwNAEkwbR+sPGrk7a5wftqQOirUz0nmI=;
        b=UctFYXnXRsA1Nk3OiJsnFE8ZY/Ev9LUO/yRKrjdJ6JoFI17LRPvT+Y6TsCvbX2SZEgwjBS
        L6us0cDDaMkGd2XxDV47ah8thWGOMbuQ5+2XkeGA2KcAQK+IFqWg/Y3SDpJomtZxun5mMO
        vhEwkIVmH7wzBai5XCHYaJerKMdh62s=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-325-jR2R2mrcPm23RPaHKHwuqw-1; Sun, 04 Oct 2020 16:55:01 -0400
X-MC-Unique: jR2R2mrcPm23RPaHKHwuqw-1
Received: by mail-qk1-f197.google.com with SMTP id w64so5279922qkc.14
        for <linux-fpga@vger.kernel.org>; Sun, 04 Oct 2020 13:55:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=mWH/ATVcRB7rwNAEkwbR+sPGrk7a5wftqQOirUz0nmI=;
        b=VwTRSATqJ2CiAX7uvIYvIhhvRpMLowCzJrOr47vFj2VMV0cQtGgAQLi+RZBnRdu2MJ
         ObVXXEEimK40/mHEOVF8dBNpANTAirbFOesokn8CyUayx1Bu9OJXDIW8p4jBTjnWndtD
         IrqzrZU3LQ3Dkd7b6a1DzM2lxnnNGL+dMkRYwe+3bjDh5VoT2E+cchgdDt4scj1O7ltS
         xYzbBBFTnYOPMIy69CC5iHQLm0fBGOmFplpdPPiYONBi+nsExMfw4RMEb2Z+mII0R4yv
         zebv9Gy/T9IyQcTzBa9UlYwkwpfvMnNF4NgLyuJlPQSB7CCW1teMD+1sQKzr6bZBLGj4
         9rwA==
X-Gm-Message-State: AOAM531DLVFQrb3c7EAXvOR10WdNrmKcCjfuP9rao6oFh2rAcLedhkpI
        AftRYHkVf9Pzvdv2ahsV41iHUy9Oyo4ySikFEanaDKI44F5IZOpV8Wt/b7gknTplf4ysA71w2Ca
        i+UZFKAJQZIDucsj9RQWp8Q==
X-Received: by 2002:a05:6214:a52:: with SMTP id ee18mr6575007qvb.39.1601844901114;
        Sun, 04 Oct 2020 13:55:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx7ljUKirqqONC/NLVsmD8e12Wp8sO1Z5hEP2gFusS5Ws9vES2qIHHnxW6he4aW9gqe3Vqekw==
X-Received: by 2002:a05:6214:a52:: with SMTP id ee18mr6574990qvb.39.1601844900893;
        Sun, 04 Oct 2020 13:55:00 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id f3sm1232955qtp.57.2020.10.04.13.54.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Oct 2020 13:55:00 -0700 (PDT)
Subject: Re: [PATCH v2 2/7] fpga: sec-mgr: enable secure updates
To:     Russ Weight <russell.h.weight@intel.com>, mdf@kernel.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     lgoncalv@redhat.com, yilun.xu@intel.com, hao.wu@intel.com,
        matthew.gerlach@intel.com
References: <20201002223701.1317-1-russell.h.weight@intel.com>
 <20201002223701.1317-3-russell.h.weight@intel.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <e34026b4-70e9-2798-6e8f-d0d3f1e19c91@redhat.com>
Date:   Sun, 4 Oct 2020 13:54:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20201002223701.1317-3-russell.h.weight@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 10/2/20 3:36 PM, Russ Weight wrote:
> Extend the FPGA Intel Security Manager class driver to
> include an update/filename sysfs node that can be used
> to initiate a security update.  The filename of a secure
> update file (BMC image, FPGA image, Root Entry Hash image,
> or Code Signing Key cancellation image) can be written to
> this sysfs entry to cause a secure update to occur.
>
> The write of the filename will return immediately, and the
> update will begin in the context of a kernel worker thread.
> This tool utilizes the request_firmware framework, which
> requires that the image file reside under /lib/firmware.
>
> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> ---
> v2:
>   - Bumped documentation date and version
>   - Removed explicit value assignments in enums
>   - Other minor code cleanup per review comments 
> ---
>  .../ABI/testing/sysfs-class-ifpga-sec-mgr     |  13 ++
>  drivers/fpga/ifpga-sec-mgr.c                  | 157 ++++++++++++++++++
>  include/linux/fpga/ifpga-sec-mgr.h            |  49 ++++++
>  3 files changed, 219 insertions(+)

This was 05/12 in the old patchset.

Looks good.

Reviewed-by: Tom Rix <trix@redhat.com>


