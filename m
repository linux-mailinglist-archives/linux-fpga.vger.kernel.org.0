Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B92A326969C
	for <lists+linux-fpga@lfdr.de>; Mon, 14 Sep 2020 22:30:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726061AbgINUaB (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 14 Sep 2020 16:30:01 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:46557 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726055AbgINU3x (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 14 Sep 2020 16:29:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600115391;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=nrjImHkfYSt9Qt9fNE59GsU5TgWd+91tpvVywiXI6Sg=;
        b=BjZ5AvvgqSezNgh9zDmv4Y8BnfexsJ77AX0zq5YilJs70AjBtdnnQKhmyRfdagykAj2B/u
        I8xs1ETVGyUr1pRWEbnbVGcSb7/44LASPevbJMkv5piqENyCSNT0maWkBZmDxPKOujRKEM
        Hy3EKBsfiQnWav1Zs7Wi3AwhAtzpIno=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-190-8hPpwK8vMjqa-rZxm9IZcg-1; Mon, 14 Sep 2020 16:29:50 -0400
X-MC-Unique: 8hPpwK8vMjqa-rZxm9IZcg-1
Received: by mail-qt1-f199.google.com with SMTP id o14so899454qtq.0
        for <linux-fpga@vger.kernel.org>; Mon, 14 Sep 2020 13:29:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=nrjImHkfYSt9Qt9fNE59GsU5TgWd+91tpvVywiXI6Sg=;
        b=Sfg34dOGh520248u1DYJhyrEOHAxTckBqez0kJ3182vAcbBRh+W1dZINGTtrZtPi8a
         htW2h6YEUyfwWVU496aTdVAoPbpU87GpwF1O5R91HOX+YwtoOR6zf/LrKQ8TAXooYzvt
         dfvdkITZf0i8HWJ/6/W3+UW33cZq6FWjrdyHUUlya4KqFDmFXPSenec1Eg9j44NPYMkk
         zOZCdKAKKpajNJVS1k2DgeyO51ohPVwVL1WKKVoOKH2ayKZBhdYm/iznWGKaBtEIkb/1
         csfnwA7KE1pCAcPuNZDyEf16gwUOaIPjwgRx3fwa+oowJ9M+TeryP+XVTCA9FzGah3GE
         Pp6w==
X-Gm-Message-State: AOAM530nxX4X8Dmt5cXhv7Gm8rJpHTiIJ3CpiRkw8F/lg+9A23CLpiY7
        /j5lsok1T9N6JGRNaWfb5fxOFHD0++oHkJoijXhJ04Ld56KgUaEnn0P9oLBT3NnBGK8VYGsPTqx
        bKhq10yFjdLD4QU1mPYQVtw==
X-Received: by 2002:ae9:e40d:: with SMTP id q13mr5895640qkc.24.1600115389452;
        Mon, 14 Sep 2020 13:29:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxNOR5DIyqhCopP+7j5biAQmTFKcAmmCN7UE4xvzZDkRFAfFko+mNdz5mMwmSQPKRSTZRfGcQ==
X-Received: by 2002:ae9:e40d:: with SMTP id q13mr5895625qkc.24.1600115389234;
        Mon, 14 Sep 2020 13:29:49 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id f127sm15339014qke.133.2020.09.14.13.29.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Sep 2020 13:29:48 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
Subject: RFC improving amount of content in 5.11
To:     "mdf@kernel.org" <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>
Cc:     "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>
Message-ID: <3295710c-5e82-7b97-43de-99b9870a8c8c@redhat.com>
Date:   Mon, 14 Sep 2020 13:29:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

I am disappointed with how little content is making it into 5.10


So I was wondering what we can do generally and i can do specifically

to improve this.


My comment

Though we are a low volume list, anything non trivial takes about 8 revisions.

My suggestion is that we all try to give the developer our big first

pass review within a week of the patch landing and try to cut the

revisions down to 3.


Tom

