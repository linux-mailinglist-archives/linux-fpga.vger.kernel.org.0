Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05ED71F3E84
	for <lists+linux-fpga@lfdr.de>; Tue,  9 Jun 2020 16:45:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726395AbgFIOp2 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 9 Jun 2020 10:45:28 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:20218 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728601AbgFIOp1 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 9 Jun 2020 10:45:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591713926;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D0N8IG0w6TqyvrPZq3Bf6WEEBOpAcUrPcq971x3xCR0=;
        b=KiW+sUf40IGeFLP0CBk6z6ojC2g+Q6URZBahsgm6rI4TyUxGfVTFCvJsQcVIcAk92gMXA9
        rHhvp5gIWj99A3BV0bwX+m1ynD85K8jZhYKTAgTPMdeqpe63goTMqyIiPDfF5LJ7ITyldw
        7Z9a3pMiC0wSkzZlYToT/vkRtEDdAAs=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-232-OipVd1hXMimxnmBZ9sKfAg-1; Tue, 09 Jun 2020 10:45:23 -0400
X-MC-Unique: OipVd1hXMimxnmBZ9sKfAg-1
Received: by mail-qt1-f198.google.com with SMTP id t24so18574311qtj.15
        for <linux-fpga@vger.kernel.org>; Tue, 09 Jun 2020 07:45:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=D0N8IG0w6TqyvrPZq3Bf6WEEBOpAcUrPcq971x3xCR0=;
        b=bSv770j8T+N4m4B0OhJtuOCqiZOD2Eh6XSBlJYZsGM6YbXwnEr2fWgGficMjXUzI0e
         FKYjgnvtdhNqBk0fF9fbhJi1LmBCzzedftaAHyBJlPOEapTCG1QRKNmVM4H1XHekYID9
         nhVNBlsHpVVjvUDGNJqapxbUr/+jH+D0bDk3yfAxDk6/LBmWHVo3yXXVI8/9Xtddv8hq
         utfXJYbCyxtz+QjMdmH74tCPGh7DdN4QvtWxkwPCw+kPsLsh4VtAZMep41e5NC469dlI
         78BQpTXL97giklbTfouCxP3R36/wzIBdAP+T+FL2nNx5u8u2/JC/YcpQDPsGkUer20y4
         je6A==
X-Gm-Message-State: AOAM533K7X+ckNORCD0wNTkDmCmaHn8lpwwaC+L2ZdEqnpieN/ue43dS
        M4Kw8a+mVD6QWWow8IEhytO05vMMeXYFyNuQB99Br/RGrwgw0EeIoK4CqBMRnkPslGdI0npf3RG
        ivO/fihm3q59Y4klvz5wKzw==
X-Received: by 2002:a37:7645:: with SMTP id r66mr27146849qkc.397.1591713921611;
        Tue, 09 Jun 2020 07:45:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxrDWGGcedgDp0WJSfkST6HxfilfGNNkZ2qb1/AuAvSqBZwRXvtCKZT5td9mD5UlkwPlyTrdg==
X-Received: by 2002:a37:7645:: with SMTP id r66mr27146798qkc.397.1591713921109;
        Tue, 09 Jun 2020 07:45:21 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id f43sm11650042qte.58.2020.06.09.07.45.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2020 07:45:20 -0700 (PDT)
Subject: Re: [PATCH 1/1] selftests: fpga: dfl: A test for afu interrupt
 support
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     stable <stable@vger.kernel.org>, linux-fpga@vger.kernel.org,
        shuah@kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
References: <20200609130208.27390-1-trix@redhat.com>
 <20200609130208.27390-2-trix@redhat.com> <20200609142007.GA831428@kroah.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <d3d8e518-0760-8cbe-cf74-191f70329a46@redhat.com>
Date:   Tue, 9 Jun 2020 07:45:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200609142007.GA831428@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


> Why not use the ksft_* functions and frameworks to properly print out
> the test status and results so that tools can correctly parse it?
>
> It's generally bad-form to make up your own format.

I used the the drivers/dma-buf test a basis example.  Can you point me at a better example ?

T

> thanks,
>
> gre gk-h
>

