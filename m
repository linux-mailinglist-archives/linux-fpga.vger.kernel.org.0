Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E912282D8C
	for <lists+linux-fpga@lfdr.de>; Sun,  4 Oct 2020 22:43:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726345AbgJDUng (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 4 Oct 2020 16:43:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:49727 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726313AbgJDUng (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 4 Oct 2020 16:43:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601844214;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jZ2kTKiFO3mkdMEg8ILVmGdnJBT4O9bHhq3zxcUrH+w=;
        b=Bo5uogp13x+1oRrnOkluZdDjuSl/X5JsZUryijUibsBfBsCC6xAwlzwRjDOs+mwHWEPjln
        Cs2O0FdR5k6JE4HRUhmS1kByIvls0Gea4R8G1q3805r+UD0IZ2ZSemwb8aOTwcq38HjpOJ
        WPYshUJzSL+suzw7pSuy6nQlbl7+/S8=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-556-o-eBjJtZNIezWXXRGGnPUQ-1; Sun, 04 Oct 2020 16:43:33 -0400
X-MC-Unique: o-eBjJtZNIezWXXRGGnPUQ-1
Received: by mail-qt1-f197.google.com with SMTP id b18so5187318qto.4
        for <linux-fpga@vger.kernel.org>; Sun, 04 Oct 2020 13:43:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=jZ2kTKiFO3mkdMEg8ILVmGdnJBT4O9bHhq3zxcUrH+w=;
        b=Chi2hE/QTkE6iJXv4VxMWz1DsmG071CU7QUHTrneKu6IWtTcG3A/7lOK93uR/o0Ev+
         1OTvFqKteiaUvt5wi/bNJhRwNfpz98ofBfkjDaJJGi9Z6DYfUFSZFbzrvjcfP/A+ukEt
         8XJo1nCa+03DXy7VAw75tWREGHQmSw6SEMm7MadZgNVm4Qmu9og8xUQsiI51HbtOMeVw
         rtOnc4cH/mjrfUif2rYxAksDRvLuMV0vS46m0qTOZVsAqq56UIE3RytYE20t4+jun6Hz
         R62DZGeouOjYxdy8hDO1rFPn3FGPwqaZdRzuRLqCS5PQsjKkEvvwWq7ZAAxG/db6n46r
         8Vww==
X-Gm-Message-State: AOAM532VBNynBTygJ1KvEh0FlHwyBBsP70rq1AZJd7RPdc3VAQs0Bpcg
        4huL8iOCAU9OvRqWgCD8GISy3jcAM0SyGPZdeqQ2T3gZFeLofmeTJh6/uC8wyZb0aLoHD9S1jtO
        dBaZwwMrVGl+ESxeSdgWUVQ==
X-Received: by 2002:ac8:70d8:: with SMTP id g24mr10035867qtp.221.1601844212661;
        Sun, 04 Oct 2020 13:43:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw+GbC8nBNvRHq2uFSKkOacyczKoG8HTcDjmrTKr+v+rjzitUTE3Whsdyx9T/BNAyK0MOmyDA==
X-Received: by 2002:ac8:70d8:: with SMTP id g24mr10035850qtp.221.1601844212405;
        Sun, 04 Oct 2020 13:43:32 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id j9sm6048077qtq.36.2020.10.04.13.43.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Oct 2020 13:43:31 -0700 (PDT)
Subject: Re: [PATCH v2 1/7] fpga: sec-mgr: intel fpga security manager class
 driver
To:     Russ Weight <russell.h.weight@intel.com>, mdf@kernel.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     lgoncalv@redhat.com, yilun.xu@intel.com, hao.wu@intel.com,
        matthew.gerlach@intel.com
References: <20201002223701.1317-1-russell.h.weight@intel.com>
 <20201002223701.1317-2-russell.h.weight@intel.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <171cfcae-07a2-51a4-64bc-4cdf58c2226a@redhat.com>
Date:   Sun, 4 Oct 2020 13:43:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20201002223701.1317-2-russell.h.weight@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 10/2/20 3:36 PM, Russ Weight wrote:
> Create the Intel Security Manager class driver. The security
> manager provides interfaces to manage secure updates for the
> FPGA and BMC images that are stored in FLASH. The driver can
> also be used to update root entry hashes and to cancel code
> signing keys.
>
> This patch creates the class driver and provides sysfs
> interfaces for displaying root entry hashes, canceled code
> signing keys and flash counts.
>
> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> ---
> v2:
>   - Bumped documentation dates and versions
>   - Added Documentation/fpga/ifpga-sec-mgr.rst 
>   - Removed references to bmc_flash_count & smbus_flash_count (not supported)
>   - Split ifpga_sec_mgr_register() into create() and register() functions
>   - Added devm_ifpga_sec_mgr_create()
>   - Removed typedefs for imgr ops
> ---
>  .../ABI/testing/sysfs-class-ifpga-sec-mgr     |  67 +++
>  Documentation/fpga/ifpga-sec-mgr.rst          |  50 ++
>  Documentation/fpga/index.rst                  |   1 +
>  MAINTAINERS                                   |   9 +
>  drivers/fpga/Kconfig                          |   9 +
>  drivers/fpga/Makefile                         |   3 +
>  drivers/fpga/ifpga-sec-mgr.c                  | 432 ++++++++++++++++++
>  include/linux/fpga/ifpga-sec-mgr.h            |  81 ++++
>  8 files changed, 652 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-class-ifpga-sec-mgr
>  create mode 100644 Documentation/fpga/ifpga-sec-mgr.rst
>  create mode 100644 drivers/fpga/ifpga-sec-mgr.c
>  create mode 100644 include/linux/fpga/ifpga-sec-mgr.h

Thanks for the changes, looks good.

Reviewed-by: Tom Rix <trix@redhat.com>


