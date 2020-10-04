Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4757C282DB4
	for <lists+linux-fpga@lfdr.de>; Sun,  4 Oct 2020 23:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbgJDVN5 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 4 Oct 2020 17:13:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:39805 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726313AbgJDVN5 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 4 Oct 2020 17:13:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601846036;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D5g8z6S2B6j+xxiFBjjsrhfdJC7yATVO13gI0yfLlEc=;
        b=AIi6XBnRwfxR++z3fsbDK4bGoimd1sVwR+S4RGHGiloiu1K8KDyaYVbY7/z3yIvKE0smYu
        f9ulAOWFuwMLZMtMeWxDEq9Tx3jGH1P0yoku4OY7umCCft1DV6qOTAeMuerXpyHhydqtEg
        7m+n8LEat/2NVKj1q84XN7X2ZWFd5sw=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-104-BaTzWji3MiidxXOxd66dvw-1; Sun, 04 Oct 2020 17:13:54 -0400
X-MC-Unique: BaTzWji3MiidxXOxd66dvw-1
Received: by mail-qv1-f70.google.com with SMTP id ec4so2051888qvb.21
        for <linux-fpga@vger.kernel.org>; Sun, 04 Oct 2020 14:13:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=D5g8z6S2B6j+xxiFBjjsrhfdJC7yATVO13gI0yfLlEc=;
        b=UBwYfdOv0XwF9k9JSBcloTZTGe6r+CvSiQ/uy/wisDZVnCEkay+qxzw3Zab6iTJrNU
         2rpCXI6r801eIXlqoX5Kjg0vz4oaihipH7/FKFATgSigWiat3wyTqxfgs6+2zCyX0RUN
         DrEe7GC7SglU5jD/Pvj+tWsecbUx5dwj8xBjQamY236pnhJmfJhVWwVHEgAgvR0HVKzl
         Wudv4w1lXmk5YNj1YXnDV0mSb4lXeO1UHCTqAa0JxGZIOXHTMOe4CJWd6OUGIq+roCxr
         wvaiFx+EHoNPZbHwKxqZTOltFH0vjhVR9FYvRAFLeRxGQw40mRm90KfCjj58pPPTaXP2
         kbWQ==
X-Gm-Message-State: AOAM530In/31e5lruX0uCql4ncW/V8scBvX7n48YWJCtt9pNA9+BhJVk
        oo4DhQzuB2YPpu0g3TdwHFRFNloEHERDekUQwZv5XJCCtYuLK2sbOyKbN4xZhb40EgKQm+3FdmA
        mFWleDUGy+pH5ITFl6JAgUw==
X-Received: by 2002:a0c:8b02:: with SMTP id q2mr11889457qva.48.1601846033973;
        Sun, 04 Oct 2020 14:13:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwBm/DNLaWx5TY+QXm8x86b1+eqf3lzpjMrjev3k2uVCPg0ICM6del+7XR+gIKDjzCzbdNIjg==
X-Received: by 2002:a0c:8b02:: with SMTP id q2mr11889447qva.48.1601846033788;
        Sun, 04 Oct 2020 14:13:53 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id 12sm5779154qty.34.2020.10.04.14.13.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Oct 2020 14:13:53 -0700 (PDT)
Subject: Re: [PATCH v2 6/7] fpga: sec-mgr: enable cancel of secure update
To:     Russ Weight <russell.h.weight@intel.com>, mdf@kernel.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     lgoncalv@redhat.com, yilun.xu@intel.com, hao.wu@intel.com,
        matthew.gerlach@intel.com
References: <20201002223701.1317-1-russell.h.weight@intel.com>
 <20201002223701.1317-7-russell.h.weight@intel.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <ba28b4b3-11f3-e4a0-da77-8336810b30fd@redhat.com>
Date:   Sun, 4 Oct 2020 14:13:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20201002223701.1317-7-russell.h.weight@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 10/2/20 3:37 PM, Russ Weight wrote:
> Extend the Intel Security Manager class driver to include
> an update/cancel sysfs file that can be written to request
> that an update be canceled. The write may return EBUSY if
> the update has progressed to the point that it cannot be
> canceled by software or ENODEV if there is no update in
> progress.
>
> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> ---
> v2:
>   - Bumped documentation date and version
>   - Minor code cleanup per review comments 
> ---
>  .../ABI/testing/sysfs-class-ifpga-sec-mgr     | 10 ++++
>  drivers/fpga/ifpga-sec-mgr.c                  | 59 +++++++++++++++++--
>  include/linux/fpga/ifpga-sec-mgr.h            |  1 +
>  3 files changed, 66 insertions(+), 4 deletions(-)

This is 10/12 of the original patch set.

Discussions covered most of my issues, the others are changed here.

Reviewed-by: Tom Rix <trix@redhat.com>


