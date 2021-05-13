Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D355537FAAC
	for <lists+linux-fpga@lfdr.de>; Thu, 13 May 2021 17:27:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234784AbhEMP2f (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 13 May 2021 11:28:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28320 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234586AbhEMP2f (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 13 May 2021 11:28:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620919644;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=syc9KYvk2Qv0VepNu59RlX1jozcF6x0a6FAg9dMOIuw=;
        b=Ad2XCciOgvc+RdHgDIEGyBKrpkVs54tBJAmUwr5e8eC3/UpOnqksK9SXb28krI+YNwQhHe
        4VniHtiMADIO3VxjPQ67tGDZK8w9JNp0DSrTAF8mk30Hh5h2yx+YUPucTD0MUU+5jpCkKe
        7HdoFwuLUCWZxD5Ha+KOYIG6wIVNVwI=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-177-_5rK7dIGPD6aFW2Jfuq_Bg-1; Thu, 13 May 2021 11:27:21 -0400
X-MC-Unique: _5rK7dIGPD6aFW2Jfuq_Bg-1
Received: by mail-qk1-f198.google.com with SMTP id p133-20020a37428b0000b02902de31dd8da3so19775302qka.1
        for <linux-fpga@vger.kernel.org>; Thu, 13 May 2021 08:27:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=syc9KYvk2Qv0VepNu59RlX1jozcF6x0a6FAg9dMOIuw=;
        b=rYeELK9Iled9fRKxBFRYySvr9Zakv0JvOmRfMNOo44BbXaF9w5Yomn3H2O7FBo6098
         WWKgK3UuGrUFpmRlOE/Y1+J0qe6ced9jb3xx1wKMCGWZdnwmgPx5qG0Qr+K9PjUWrEqH
         ltc01swER+ASEV+g14QkV5co9MFbdJuwIBm57C3M/4klQTe9SS3ru1vC7Ou/xkstkmQu
         keUc1SQmt2WwFD+O8Y/wLz/wZedTw+VWyh9pgquj1Syb121gmn5FC8JEcqW3siXwjtfe
         JO9FmJlQj3z69JdD4w+plEaVFRwVzEp4dEd6EZdbzkj/pzxXS5JH8ZhEOMaGLLeQUTbI
         b9yg==
X-Gm-Message-State: AOAM533YHnG1t6cecBBtiAcKBHq3VNY7h9/38Stra7hkQa4udUaqH7I2
        Q315VRWMnrgecakbl9mn2EGjPsqbMmiLPsZhmx/cPoCvpvEkLm9jj8Uyb25XjqsFQxeSRRXG51Z
        7UTsdck2b8Foy/uqCtv9OJw==
X-Received: by 2002:a05:620a:20d7:: with SMTP id f23mr19036859qka.484.1620919640668;
        Thu, 13 May 2021 08:27:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx3s/xgTHrnlHcj6/c+rnyyDWYIe13AuITQm/PZaxgBas7dHJddX7yNG1GdULm1D6prHyFK6Q==
X-Received: by 2002:a05:620a:20d7:: with SMTP id f23mr19036838qka.484.1620919640467;
        Thu, 13 May 2021 08:27:20 -0700 (PDT)
Received: from localhost.localdomain (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id 123sm2695552qkg.0.2021.05.13.08.27.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 May 2021 08:27:20 -0700 (PDT)
Subject: Re: [PATCH V6 XRT Alveo 08/20] fpga: xrt: driver infrastructure
To:     Lizhi Hou <lizhi.hou@xilinx.com>, linux-kernel@vger.kernel.org
Cc:     linux-fpga@vger.kernel.org, maxz@xilinx.com,
        sonal.santan@xilinx.com, yliu@xilinx.com, michal.simek@xilinx.com,
        stefanos@xilinx.com, devicetree@vger.kernel.org, mdf@kernel.org,
        robh@kernel.org, Max Zhen <max.zhen@xilinx.com>
References: <20210512015339.5649-1-lizhi.hou@xilinx.com>
 <20210512015339.5649-9-lizhi.hou@xilinx.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <c6ed9349-1a9a-62a9-521f-a12ec8c4a5a5@redhat.com>
Date:   Thu, 13 May 2021 08:27:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210512015339.5649-9-lizhi.hou@xilinx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 5/11/21 6:53 PM, Lizhi Hou wrote:
> Infrastructure code providing APIs for managing leaf driver instance
> groups, facilitating inter-leaf driver calls and root calls.
>
> Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
> Signed-off-by: Max Zhen <max.zhen@xilinx.com>
> Signed-off-by: Lizhi Hou <lizhi.hou@xilinx.com>
> Reviewed-by: Tom Rix <trix@redhat.com>

> +
> +int xrt_subdev_root_request(struct xrt_device *self, u32 cmd, void *arg)
> +{
> +	struct device *dev = DEV(self);
> +	struct xrt_subdev_platdata *pdata = DEV_PDATA(self);
> +
> +	WARN_ON(!pdata->xsp_root_cb);
> +	return (*pdata->xsp_root_cb)(dev->parent, pdata->xsp_root_cb_arg, cmd, arg);

I am running v6 through clang's static analyzer.

It reports this problem

drivers/fpga/xrt/lib/subdev.c:72:9: warning: Called function pointer is 
null (null dereference)
         return (*pdata->xsp_root_cb)(dev->parent, 
pdata->xsp_root_cb_arg, cmd, arg);
^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Though there is a warn_on, can you also add a

return -EINVAL;

To cover this case?

Tom

> +}

