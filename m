Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 070C5282DA9
	for <lists+linux-fpga@lfdr.de>; Sun,  4 Oct 2020 23:06:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726519AbgJDVGv (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 4 Oct 2020 17:06:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27088 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726351AbgJDVGu (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 4 Oct 2020 17:06:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601845609;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HOSd6fXQnXybQ36w4uIi1a1hr5nnmrxJ6QtsUC5yq7w=;
        b=LcFPXwfKJQUU/FBMZlERCnQTY3fi9mlj2oN8iMBcKsLJcVcAci71sfw3+f5pJAIKF+rA8l
        Jc7Q62z3D1J36MIxP12ma1VXXcdAuQcMnI8Vr+YPg9jD9uh19+vIRupAXaH1me1DkWChaA
        ivnTPJXUSN8AbRQkN3Z9on+pz+xM8/o=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-141-s2MWkxuvOWKEehueG4zFDA-1; Sun, 04 Oct 2020 17:06:47 -0400
X-MC-Unique: s2MWkxuvOWKEehueG4zFDA-1
Received: by mail-qk1-f197.google.com with SMTP id s9so5234703qks.21
        for <linux-fpga@vger.kernel.org>; Sun, 04 Oct 2020 14:06:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=HOSd6fXQnXybQ36w4uIi1a1hr5nnmrxJ6QtsUC5yq7w=;
        b=K+uowXfR35DBn7WZaf9G7YbV+n0m7Dn+3oj/UzvdmkVNkWFfZnDa4f+1TyrtseAH6Z
         RyRajQRoEEsIZlFcIHGjlYWRLgGolFcniS37ku46MvmEBaIxri5TZhQCEmDnAkjZRDiB
         Qis5Srztq2oCJxg6Bu+tsK8O62S7latAgNR7/hp65k7d7CGyoSBcaSFNN0lMv+k6vOoI
         hyFnuF17IkJc1cTrrgC1yx7+E28ErLQGGvB1zO7w2gOIp0i2Pbxqrdv8bRfEEVmX5Vl2
         CIvnqrDqGGc9cNQ4Kr9LTQp58WEsOwpxOHeAj6J68VagKPYKpCu81ncneob5imnoicnS
         cuvg==
X-Gm-Message-State: AOAM530akQ/m0qngQDOJCBrpTQk4rVEQayN1KHEG0PtpAu9JoHTPQgB9
        0ZOl53X0qwdblNY3CQrwyC6hofHZiUsrGB1mUdN6AYPDq/AUK2h3TcLQhYxgjQd6RD/g6NYSE0t
        kiYkt/e/VeKS91WKD9G95lw==
X-Received: by 2002:a05:620a:2213:: with SMTP id m19mr11339338qkh.472.1601845607333;
        Sun, 04 Oct 2020 14:06:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz8D6i/YlfAGtBLPSW3AvZb8V1G6iekhK4asTFJYCkHDkoCPbaqz94kc0BpVukahCdA3j7MSA==
X-Received: by 2002:a05:620a:2213:: with SMTP id m19mr11339316qkh.472.1601845607108;
        Sun, 04 Oct 2020 14:06:47 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id w18sm6078127qtt.19.2020.10.04.14.06.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Oct 2020 14:06:46 -0700 (PDT)
Subject: Re: [PATCH v2 4/7] fpga: sec-mgr: expose sec-mgr update errors
To:     Russ Weight <russell.h.weight@intel.com>, mdf@kernel.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     lgoncalv@redhat.com, yilun.xu@intel.com, hao.wu@intel.com,
        matthew.gerlach@intel.com
References: <20201002223701.1317-1-russell.h.weight@intel.com>
 <20201002223701.1317-5-russell.h.weight@intel.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <70b5ec16-e252-b463-60f6-9a03fa654b34@redhat.com>
Date:   Sun, 4 Oct 2020 14:06:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20201002223701.1317-5-russell.h.weight@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 10/2/20 3:36 PM, Russ Weight wrote:
> Extend Intel Security Manager class driver to include
> an update/error sysfs node that can be read for error
> information when a secure update fails.
>
> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> ---
> v2:
>   - Bumped documentation date and version
>   - Added warning to sec_progress() for invalid progress status
>   - Added sec_error() function (similar to sec_progress())
> ---
>  .../ABI/testing/sysfs-class-ifpga-sec-mgr     | 17 ++++
>  drivers/fpga/ifpga-sec-mgr.c                  | 81 ++++++++++++++++---
>  include/linux/fpga/ifpga-sec-mgr.h            |  1 +
>  3 files changed, 89 insertions(+), 10 deletions(-)

This is 08/12 of the old patchset.

Also fine.

Reviewed-by: Tom Rix <trix@redhat.com>


