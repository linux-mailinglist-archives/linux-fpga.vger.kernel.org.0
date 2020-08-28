Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14F8C2561E7
	for <lists+linux-fpga@lfdr.de>; Fri, 28 Aug 2020 22:18:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbgH1USG (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 28 Aug 2020 16:18:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51466 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726033AbgH1USD (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Fri, 28 Aug 2020 16:18:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598645882;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KWyHfTHifX4s3mVQhhcUAJcvryyZ6mo0hzR0AcO35fk=;
        b=Whppa+bZpo+1zTU+t5CcmD1uwl+LQRfHX8YHKtIpJ/1ZtwwD5mytcx7yJBJxB0WG0ZrpAu
        0TJxVEjveRLF5jH9QKYxqNfe3W9C9jwz3CTBRDf5kqIGCa+Z3pgi0PMLbd0tZXRoOHZTCW
        h2moTccYeGQrn1sBFF29m+ykQSCOOQ8=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-35-8zmgSkpNPd2amr-rl0JwsQ-1; Fri, 28 Aug 2020 16:18:00 -0400
X-MC-Unique: 8zmgSkpNPd2amr-rl0JwsQ-1
Received: by mail-oi1-f198.google.com with SMTP id l6so186156oia.15
        for <linux-fpga@vger.kernel.org>; Fri, 28 Aug 2020 13:18:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=KWyHfTHifX4s3mVQhhcUAJcvryyZ6mo0hzR0AcO35fk=;
        b=kz9rO1i5MXDoBaFpacCzPBUv6ZdXGQU4t40LXl2k0tL/ppYpZ23sZV3Xe35QsN2Ih4
         iHyAkzeIaQYjP5Tn+HJodvwL2v3gnmwA/X2JsW4vKiquOJeNsmTpiX37bLQzDkIHnA04
         wP7gyXDfitU3sDVs01LdOMuIWjrKWNo8k1V9OyQF/EVUjB+Ypyyz49KaymltsJg6w6GU
         FLh9x0zjr4PKeWTgKBWItGWvzc0GIQ6lX0IoIq+5tCdFgxr9FjnYVNHpBNp18+yz8xGL
         fh/+/SwCuugUNVx9pQZd4msuEnfdXNNvDt/SUo5vMCvBcpGGGzIIiq32vRju3PZzQfWN
         963w==
X-Gm-Message-State: AOAM532dXVQap4srRCWe56MUP6RGxat55i5fm+Z//CKcxUOf37kcVI5V
        ZeTaoO4Ergvk4ZDulXzZ9kcLA5j0bxEStJzv6u2eKyFirAnT77C0udYRtg4XLh2y/SSVrkcP97D
        qYI/J6iKoBioDMB2QKA0LPQ==
X-Received: by 2002:a05:6830:20d1:: with SMTP id z17mr263793otq.179.1598645879654;
        Fri, 28 Aug 2020 13:17:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw0nfNYShd/fLaNgYR9tr4qsn5gYzr5yuS0DTc5RPzbGI202F6TSa9iWZ9O85GKeYOjvc4HsA==
X-Received: by 2002:a05:6830:20d1:: with SMTP id z17mr263783otq.179.1598645879392;
        Fri, 28 Aug 2020 13:17:59 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id z13sm62938oia.30.2020.08.28.13.17.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Aug 2020 13:17:58 -0700 (PDT)
Subject: Re: [PATCH v3 5/5] fpga manager: xilinx-spi: provide better
 diagnostics on programming failure
To:     Luca Ceresoli <luca@lucaceresoli.net>, linux-fpga@vger.kernel.org
Cc:     Moritz Fischer <mdf@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anatolij Gustschin <agust@denx.de>
References: <20200828195808.27975-1-luca@lucaceresoli.net>
 <20200828195808.27975-5-luca@lucaceresoli.net>
From:   Tom Rix <trix@redhat.com>
Message-ID: <20e0b1e3-938e-9020-a4b5-02e24692557d@redhat.com>
Date:   Fri, 28 Aug 2020 13:17:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200828195808.27975-5-luca@lucaceresoli.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 8/28/20 12:58 PM, Luca Ceresoli wrote:
> When the DONE pin does not go high after programming to confirm programming
> success, the INIT_B pin provides some info on the reason. Use it if
> available to provide a more explanatory error message.
>
> Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>

This patch set looks good to me.

Thanks

Tom

Reviewed-by: Tom Rix <trix@redhat.com>


