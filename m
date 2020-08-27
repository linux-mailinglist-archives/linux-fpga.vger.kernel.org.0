Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD49B254DF3
	for <lists+linux-fpga@lfdr.de>; Thu, 27 Aug 2020 21:04:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbgH0TEb (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 27 Aug 2020 15:04:31 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:32003 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726853AbgH0TE3 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 27 Aug 2020 15:04:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598555067;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dpPTnyY1jEEF6hodFsVeyGCg6LIEq1osNtlESX3XqhY=;
        b=RX5GWRLSgjB/ELEIolI8uRmWvBOhI2yYr4DNY3AZgZ1CJHYVDTmFODQMupXQ9fq5SaO80Q
        sA/KGwN5LXMVi5KXSh2vxT1p+7jLKMXeQJVMJ1n1rXzmmClb5wKirNhsco6KA3Iyc5nLus
        7gJJtgd9CG6GN3nkcqoVp8emdbTPp00=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-339-q_HJX1qMO4yamLyw8xu71g-1; Thu, 27 Aug 2020 15:04:26 -0400
X-MC-Unique: q_HJX1qMO4yamLyw8xu71g-1
Received: by mail-qt1-f197.google.com with SMTP id r24so5581096qtu.3
        for <linux-fpga@vger.kernel.org>; Thu, 27 Aug 2020 12:04:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=dpPTnyY1jEEF6hodFsVeyGCg6LIEq1osNtlESX3XqhY=;
        b=XUIx6eQNo3TDtNYN/5EuVHjU3ETY4lt7fMeFv5kGTSAV8/X9Jhibcd+FO71CVKjBKP
         7Rk+976BZShaHqfNWf0caFtpIx0UiuTmZd7r+KLhCx+FY8lR2vILFKYQnM9/46jMO8xc
         w08VWX30jMZcmiJutlpWHXYJbEr5gtqWQM0SjzCG3OPhZD06gffpQ7ONNvDqWlyetNmJ
         ckpV43OFIq+N6ecQLzTpDX7E+3oAgEyj+/KW96VPczisruNxIfZ3+C0TK4Tzd+R214sb
         pgx7hevReRddPkbSBwsIw/5rnEGDdiJBm9bcLv2QH7OaAgbOTbPfMCZd/AmpTxfT7FaK
         mLUg==
X-Gm-Message-State: AOAM533Eg0k/E1QjG+awul9wneji1sDNSeq+yIS8HA/bAedrcoUV+m45
        DtnC4cqkOsMpO/yZ7Ka2kuTnRrQ/ZErbZ/KK7oRobmcHBRt+g/FzosdBq0JD2+tRrSoxFcAC8NX
        A5heBT0rORqrXNHP6pBoJag==
X-Received: by 2002:ae9:e40c:: with SMTP id q12mr17555690qkc.68.1598555065947;
        Thu, 27 Aug 2020 12:04:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxwu1wIJxuc9erShjjxOxlzaZkchq1wagQLHXczQWn9FAGBbene5P6362g6/5YgQY916BkKSw==
X-Received: by 2002:ae9:e40c:: with SMTP id q12mr17555673qkc.68.1598555065747;
        Thu, 27 Aug 2020 12:04:25 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id w20sm2464189qki.108.2020.08.27.12.04.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Aug 2020 12:04:25 -0700 (PDT)
Subject: Re: [PATCH v2 4/5] fpga manager: xilinx-spi: add error checking after
 gpiod_get_value()
To:     Luca Ceresoli <luca@lucaceresoli.net>, linux-fpga@vger.kernel.org
Cc:     Moritz Fischer <mdf@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anatolij Gustschin <agust@denx.de>
References: <20200827143249.10973-1-luca@lucaceresoli.net>
 <20200827143249.10973-4-luca@lucaceresoli.net>
From:   Tom Rix <trix@redhat.com>
Message-ID: <e0ce7edb-53dd-2961-278d-e9bc8a1726ac@redhat.com>
Date:   Thu, 27 Aug 2020 12:04:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200827143249.10973-4-luca@lucaceresoli.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 8/27/20 7:32 AM, Luca Ceresoli wrote:
> Current code calls gpiod_get_value() without error checking. Should the
> GPIO controller fail, execution would continue without any error message.
>
> Fix by checking for negative error values.
>
> Reported-by: Tom Rix <trix@redhat.com>
> Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
>
> ---

Thanks, this looks fine.

Reviewed-by: Tom Rix <trix@redhat.com>


