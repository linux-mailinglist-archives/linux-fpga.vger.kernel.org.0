Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00A7A75299C
	for <lists+linux-fpga@lfdr.de>; Thu, 13 Jul 2023 19:13:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231564AbjGMRLy (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 13 Jul 2023 13:11:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbjGMRLr (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 13 Jul 2023 13:11:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34E022719
        for <linux-fpga@vger.kernel.org>; Thu, 13 Jul 2023 10:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689268259;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+UPgPFBGvQHuZjwqO9ik4oPicS3MZwipCdBIqa3Pous=;
        b=LfQNLsC+9rUN6nDXpJh9bJPEa/8hMG5DCXVRj5Oeyu51TyEWDKOjjpur6/cxrmNuUKHOnC
        NQHilZNg4i3zUNZ+0IOQUEL++nlNjCe8peXyFt+qqE8ei7mHuRT9rAMypsdQRxj5rm6/Ir
        hPNvo1AGXWYin1KAvmnITOwpIPtXeow=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-70-vclzISmaP5-3clTC2QWokQ-1; Thu, 13 Jul 2023 13:10:58 -0400
X-MC-Unique: vclzISmaP5-3clTC2QWokQ-1
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-345c1f3dcc8so4533615ab.3
        for <linux-fpga@vger.kernel.org>; Thu, 13 Jul 2023 10:10:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689268257; x=1691860257;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+UPgPFBGvQHuZjwqO9ik4oPicS3MZwipCdBIqa3Pous=;
        b=Nq3V0wAtsymqf70zLeSk59yL8+/OTsanzt3wlBJmIAXge+3xtCjVV1WaPrQki3+1xM
         5CYzIwVubZtGAphEMq1A1sp9WD8+f6/ANNrCgPdrnXI8zUZuQJCcH5TxIFKwp6MX/h/W
         Yce/BewB0viMxUxw0YnOfaLVh7RDjn1GS9Hm9H/83UXWbybBcfzXEE6ylmtmQJjtd3K7
         bcr2DETNuEJ4lBBqcXvg2M+dlyB2FAbwpwBlxpIJ8s2hh/AL1db6cJcjO2FEXmH/JVKo
         TiBPa7xMFFZm16gP0SBH6ZUg4dURNeKYbH4yTIvubeMvdH5eubLmtE02ci6X75eViewb
         ht0w==
X-Gm-Message-State: ABy/qLbLl1LRWQUyl44NVgwsUW9hwv/Se22oRFWwOA03lxp+mT9oRoe1
        GH8QlK127toosUW6DyB0VHbCUecUB4I+D5taQRTn7HyUm03ZKOWgNNp1QTY1bL689KZ1+PUy6VS
        ntH16mUL9onFfA//6P1JzIQ==
X-Received: by 2002:a92:c105:0:b0:345:6ffa:63c5 with SMTP id p5-20020a92c105000000b003456ffa63c5mr1980572ile.32.1689268257117;
        Thu, 13 Jul 2023 10:10:57 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEYzBd2cy5+vbqrqBW5hcL0Nlt03XvoKU7EVc2Oqt6qt/39DAJLG7+eJes4a+aimrEVLy/slQ==
X-Received: by 2002:a92:c105:0:b0:345:6ffa:63c5 with SMTP id p5-20020a92c105000000b003456ffa63c5mr1980544ile.32.1689268256865;
        Thu, 13 Jul 2023 10:10:56 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id el20-20020a0566384d9400b0042b61a5087csm1948085jab.132.2023.07.13.10.10.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 10:10:56 -0700 (PDT)
Date:   Thu, 13 Jul 2023 11:10:54 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Christian Brauner <brauner@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-usb@vger.kernel.org, Matthew Rosato <mjrosato@linux.ibm.com>,
        Paul Durrant <paul@xen.org>, Tom Rix <trix@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        dri-devel@lists.freedesktop.org, Michal Hocko <mhocko@kernel.org>,
        linux-mm@kvack.org, Kirti Wankhede <kwankhede@nvidia.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Diana Craciun <diana.craciun@oss.nxp.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Shakeel Butt <shakeelb@google.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Leon Romanovsky <leon@kernel.org>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Fei Li <fei1.li@intel.com>, x86@kernel.org,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Halil Pasic <pasic@linux.ibm.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Ingo Molnar <mingo@redhat.com>,
        intel-gfx@lists.freedesktop.org,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        linux-fpga@vger.kernel.org, Zhi Wang <zhi.a.wang@intel.com>,
        Wu Hao <hao.wu@intel.com>, Jason Herne <jjherne@linux.ibm.com>,
        Eric Farman <farman@linux.ibm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andrew Donnellan <ajd@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linuxppc-dev@lists.ozlabs.org, Eric Auger <eric.auger@redhat.com>,
        Borislav Petkov <bp@alien8.de>, kvm@vger.kernel.org,
        Rodrigo Vivi <rodrigo.vivi@intel.com>, cgroups@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        virtualization@lists.linux-foundation.org,
        intel-gvt-dev@lists.freedesktop.org, io-uring@vger.kernel.org,
        netdev@vger.kernel.org, Tony Krowiak <akrowiak@linux.ibm.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Pavel Begunkov <asml.silence@gmail.com>,
        Sean Christopherson <seanjc@google.com>,
        Oded Gabbay <ogabbay@kernel.org>,
        Muchun Song <muchun.song@linux.dev>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Benjamin LaHaise <bcrl@kvack.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        Moritz Fischer <mdf@kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Xu Yilun <yilun.xu@intel.com>, jaz@semihalf.com
Subject: Re: [PATCH 0/2] eventfd: simplify signal helpers
Message-ID: <20230713111054.75cdf2b8.alex.williamson@redhat.com>
In-Reply-To: <20230713-vfs-eventfd-signal-v1-0-7fda6c5d212b@kernel.org>
References: <20230713-vfs-eventfd-signal-v1-0-7fda6c5d212b@kernel.org>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Thu, 13 Jul 2023 12:05:36 +0200
Christian Brauner <brauner@kernel.org> wrote:

> Hey everyone,
> 
> This simplifies the eventfd_signal() and eventfd_signal_mask() helpers
> by removing the count argument which is effectively unused.

We have a patch under review which does in fact make use of the
signaling value:

https://lore.kernel.org/all/20230630155936.3015595-1-jaz@semihalf.com/

Thanks,
Alex

