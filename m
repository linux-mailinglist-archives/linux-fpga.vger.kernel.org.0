Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A086A254E03
	for <lists+linux-fpga@lfdr.de>; Thu, 27 Aug 2020 21:09:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727835AbgH0TJJ (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 27 Aug 2020 15:09:09 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:58571 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727115AbgH0TJJ (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 27 Aug 2020 15:09:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598555348;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KAEZo/YE9GEddiVed/r0hHvLBr62Nk6jQkAItPMa1zw=;
        b=UIfBQrxMXqA4B85wcBiH/4ozRF4L7hC2+Q8HKKy7R7r9IepLH8Qzll0WERa7ldMwXl1TTP
        9jQ42xJSho2QbF0OpqfqFlT9WKgWF7nw9ORkhZh2mIIRwdrfoF/HJEH4atNYTQCLOHZGA6
        Wlbh6IEmiRmNwv3ISrC497/kJ5yNsh8=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-205-xWoE4v9EPaa9B3r-ls9ZXw-1; Thu, 27 Aug 2020 15:09:06 -0400
X-MC-Unique: xWoE4v9EPaa9B3r-ls9ZXw-1
Received: by mail-qv1-f70.google.com with SMTP id d9so5364674qvl.10
        for <linux-fpga@vger.kernel.org>; Thu, 27 Aug 2020 12:09:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=KAEZo/YE9GEddiVed/r0hHvLBr62Nk6jQkAItPMa1zw=;
        b=L7pTV3MOjfjtyxbYFvZElg4/ULQhe71ffjYEqjBpC3fm2/+eZjfAk/Zz1lLOGkQ/v0
         ztcct0yN7saXaOeNhdPZM+EzW6dUXlFfcFXBKjP+1Wg/M7fUbAYMUwPT379D3K8x9rFh
         2oYi9fI732Cvq5F6pX0GTih3MefIybbGgleJFB194pVDfnEavmRpy2iMjLfGiQ2cMviV
         x5C4MhtCzIT0/OfpdTj+H3SfFwuVn2Z6nOAwNrvGQDs4gjyhgREY0lOVLc3haXJuzkIa
         Kfbh5jsRZFnNfPUGhJbzqwthKvI1eYH7i2UhTRuvzSwAWkNlABUJFMpMrBNKDPV0wlaG
         uTNg==
X-Gm-Message-State: AOAM5302+/4zxcR4u630BQWRYA/SCVvhXFVVu8cBw7dx+wnlsQzehDG9
        t2gq7vH12XCNGuEXOBTdh8w376UeHgBzu7mFxzfH+zhT1X+ruljPrWC42bNrjPEhrb0EOrqkfbD
        4bf+ayy3jraUrZMgjQusiVw==
X-Received: by 2002:ac8:6a07:: with SMTP id t7mr20257281qtr.1.1598555345821;
        Thu, 27 Aug 2020 12:09:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwuHQT71lwx6nYLk2qBAQLkclZ4rkI4WcjiaeOHy8y0S6Fv5A6mtp3yabGqDWLQs3wAdEI9YA==
X-Received: by 2002:ac8:6a07:: with SMTP id t7mr20257253qtr.1.1598555345605;
        Thu, 27 Aug 2020 12:09:05 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id 7sm2553032qkp.57.2020.08.27.12.09.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Aug 2020 12:09:05 -0700 (PDT)
Subject: Re: [PATCH v2 5/5] fpga manager: xilinx-spi: provide better
 diagnostics on programming failure
To:     Luca Ceresoli <luca@lucaceresoli.net>, linux-fpga@vger.kernel.org
Cc:     Moritz Fischer <mdf@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anatolij Gustschin <agust@denx.de>
References: <20200827143249.10973-1-luca@lucaceresoli.net>
 <20200827143249.10973-5-luca@lucaceresoli.net>
From:   Tom Rix <trix@redhat.com>
Message-ID: <aa201535-a5f6-04b1-1444-35b68ed47281@redhat.com>
Date:   Thu, 27 Aug 2020 12:09:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200827143249.10973-5-luca@lucaceresoli.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 8/27/20 7:32 AM, Luca Ceresoli wrote:
> When the DONE pin does not go high after programming to confirm programming
> success, the INIT_B pin provides some info on the reason. Use it if
> available to provide a more explanatory error message.
>
> Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
>
> ---
>
> Changes in v2:
>  - also check for gpiod_get_value() errors (Tom Rix)

This looks fine.

Reviewed-by: Tom Rix <trix@redhat.com>


